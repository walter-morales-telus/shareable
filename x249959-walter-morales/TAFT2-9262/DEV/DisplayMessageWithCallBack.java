package com.netcracker.ncportal.telus.rules;

import com.netcracker.businessoe.api.entities.SalesOrder;
import static com.google.common.base.Preconditions.checkNotNull;

import com.netcracker.businessoe.controllers.OrderItemAction;
import com.netcracker.businessoe.rule.result.RuleResult;
import com.netcracker.businessoe.api.entities.catalog.ProductOffering;
import com.google.common.collect.Lists;
import com.netcracker.businessoe.api.entities.catalog.ProductOfferingCategory;
import com.netcracker.businessoe.api.entities.OrderItem;
import static com.netcracker.ncportal.generic.rules.helper.ThemePackPriorityRuleHelper.getOrderItemsByCategoryId;


import com.netcracker.businessoe.api.entities.catalog.rules.ProductOfferingRule;
import com.netcracker.businessoe.api.entities.catalog.rules.RuleElement;
import com.netcracker.businessoe.rule.expression.CustomClassExpression;
import com.netcracker.businessoe.rule.expression.ExpressionProcessorParamKey;
import com.netcracker.ncportal.generic.api.helpers.PortalContentItemHelper;
import com.netcracker.ncportal.generic.rules.helper.GeneralRuleHelper;
import com.netcracker.ncportal.generic.rules.helper.GeneralRuleLocalizationHelper;
import com.netcracker.ncportal.telus.rules.helper.OrderItemHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigInteger;
import java.util.*;

import static com.netcracker.businessoe.rule.expression.ExpressionProcessorParamKey.*;
import static com.netcracker.ncportal.generic.rules.helper.GeneralRuleHelper.*;
import static java.util.Collections.emptyList;

/* Generic bean to display a message while forcing page callback */
public class DisplayMessageWithCallBack implements CustomClassExpression {

    private static final Logger LOGGER = LoggerFactory.getLogger(DisplayMessageWithCallBack.class);

    private static final String CONTINUE_BUTTON = "ContinueButton";
    private static final String CANCEL_BUTTON = "CancelButton";
    private static final BigInteger EN_CA_LOCALE_LV_ID = BigInteger.valueOf(9143298170013689702L);

    private static  String CANCEL_BUTTON_CAPTION = "";
    private static  String CONTINUE_BUTTON_CAPTION = "";
    private static final String CANCEL_BUTTON_VALUE  = "1";
    private static final String CONTINUE_BUTTON_VALUE = "0";

    /*
    private static final String OFFERING_TO_ADD_PARAMETER = "Offers to Add";
    private static final String CONTAINER_OFFER_CATEGORY_PARAMETER = "Category for Container";

     */

    private static final String OFFER_TO_ADD = "Offer to add";
    private static final String CATEGORY_FOR_CONTAINER = "Category for container";

    @Override
    public Object execute(Map parameters) {
        ProductOfferingRule rule = (ProductOfferingRule) parameters.get(PRODUCT_OFFERING_RULE);
        LOGGER.info("Executing generic Display Message with rule : " + rule);

        BigInteger locale = GeneralRuleLocalizationHelper.getLocaleFromRuleParams(parameters);

        try {
            CANCEL_BUTTON_CAPTION = collectValuesFromTextRuleParameter(rule, CANCEL_BUTTON).get(0);
            try {
                if (locale.compareTo(EN_CA_LOCALE_LV_ID) != 0) {
                    CANCEL_BUTTON_CAPTION = PortalContentItemHelper.getLocalizedPCIForEntityByName(rule, "ruleButtonCancel", locale);
                }
            }
            catch(Exception e) {
            }
        }
        catch(Exception e) {
        }

        try {
            CONTINUE_BUTTON_CAPTION = collectValuesFromTextRuleParameter(rule, CONTINUE_BUTTON).get(0);
            try {
                if (locale.compareTo(EN_CA_LOCALE_LV_ID) != 0) {
                    CONTINUE_BUTTON_CAPTION = PortalContentItemHelper.getLocalizedPCIForEntityByName(rule, "ruleButtonContinue", locale);
                }
            }
            catch(Exception e) {
            }
        }
        catch(Exception e) {
        }

        if (isCallBack(parameters)) {
            return executeRuleCallBackAction(parameters);
        } else {
            return executeRule(parameters, locale);
        }
    }

    private boolean executeRule(Map parameters , BigInteger locale) {
        LOGGER.info("Start DisplayMessageWithCallBack execution...");
        RuleElement ruleElement = (RuleElement) parameters.get(ExpressionProcessorParamKey.RULE_ELEMENT);
        Map<String, String> actions = new LinkedHashMap<String, String>();
        if (!CONTINUE_BUTTON_CAPTION.equals("")){
            actions.put(CONTINUE_BUTTON_CAPTION, CONTINUE_BUTTON_VALUE);
        }
        if (!CANCEL_BUTTON_CAPTION.equals("")) {
            actions.put(CANCEL_BUTTON_CAPTION, CANCEL_BUTTON_VALUE);
        }
        ruleElement.setRuleActions(actions);
        return true;
    }



    private boolean executeRuleCallBackAction(Map parameters) {
        LOGGER.info("Start DisplayMessageWithCallBack callback action");
        String callbackAction = (String) parameters.get(RULE_CALLBACK_ACTION);

        if (CONTINUE_BUTTON_VALUE.equals(callbackAction)) {
            LOGGER.info("Customer pressed CONTINUE button");
            try {

                addOffer(parameters);
                ProductOfferingRule rule = (ProductOfferingRule)parameters.get(ExpressionProcessorParamKey.PRODUCT_OFFERING_RULE);
                RuleElement ruleElement = (RuleElement)parameters.get(ExpressionProcessorParamKey.RULE_ELEMENT);
                String redirectUrl = (String) GeneralRuleHelper.collectValuesFromTextRuleParameter(rule, "Redirect URL").get(0);
                ruleElement.getCustomRuleResults().put("Redirect URL", redirectUrl);
            }
            catch(Exception e) {
                LOGGER.info("No REDIRECT_URL");
                LOGGER.info("error : " + e);
            }

            return true;
        } else if (CANCEL_BUTTON_VALUE.equals(callbackAction)) {
            LOGGER.info("Customer pressed CANCEL button");
            return false;//do nothing
        }
        LOGGER.info("End DisplayMessageWithCallBack callback action");
        return true;
    }

    private void addOffer(Map params) {
        SalesOrder salesOrder = (SalesOrder) params.get(ExpressionProcessorParamKey.SALES_ORDER);
        ProductOfferingRule rule = (ProductOfferingRule) params.get(ExpressionProcessorParamKey.PRODUCT_OFFERING_RULE);
        RuleResult ruleResult = (RuleResult) params.get(ExpressionProcessorParamKey.RULE_RESULT);
        BigInteger locationId = new BigInteger(ruleResult.getLocationId());
        ProductOffering offerToAdd = parseCustomRuleParameters(rule, OFFER_TO_ADD, baseToOffering).iterator().next();
        List<ProductOfferingCategory> categoryForContainer = parseCustomRuleParameters(rule, CATEGORY_FOR_CONTAINER, baseToOfferingCategory);

        List<OrderItem> containerOrderItems = getOrderItemsByCategoryActionLocation(salesOrder.getOrderItems(),categoryForContainer, locationId,
                Arrays.asList(OrderItemAction.ADD.getStringValue(), OrderItemAction.DASH.getStringValue(), OrderItemAction.MODIFY.getStringValue()));

        OrderItem topItem = containerOrderItems.get(0);
        createAndAddChildOrderItem(topItem, offerToAdd);

    }

    private void createAndAddChildOrderItem(OrderItem orderItem, ProductOffering offerToAdd) {
        OrderItem orderItemToAdd = createChildOrderItem(offerToAdd, orderItem.getCustomerLocationId(), emptyList(), emptyList());
        orderItem.addOrderItem(orderItemToAdd);
    }

    /*
    private void addOffering(Map parameters){

        LOGGER.info("Start execution of adding offering");

        SalesOrder salesOrder = checkNotNull((SalesOrder) parameters.get(SALES_ORDER));
        RuleResult ruleResult = checkNotNull((RuleResult) parameters.get(RULE_RESULT));
        ProductOfferingRule rule = (ProductOfferingRule)parameters.get(ExpressionProcessorParamKey.PRODUCT_OFFERING_RULE);

        List<ProductOffering> offeringsToAdd = parseCustomRuleParameters(rule, OFFERING_TO_ADD_PARAMETER, baseToOffering);
        List<ProductOfferingCategory> containerCategories = parseCustomRuleParameters(rule, CONTAINER_OFFER_CATEGORY_PARAMETER, baseToOfferingCategory);
        List<OrderItem> containerOrderItems = Lists.newArrayList();
        List<OrderItem> containerByCategory = getOrderItemsByCategoryId(salesOrder, Lists.transform(containerCategories, baseId), true);
        containerOrderItems.addAll(containerByCategory);
        LOGGER.info("container order items: {}", Arrays.toString(containerOrderItems.toArray()));

        BigInteger locationId = new BigInteger(ruleResult.getLocationId());
        Collection<BigInteger> customerMarketsIds = OrderItemHelper.getMarketsByLocationId(locationId);
        offeringsToAdd = OrderItemHelper.checkOfferingsEligibility(offeringsToAdd, customerMarketsIds);

        if (offeringsToAdd.size() > 0) {
            OrderItemHelper.addOrderItemsToContainers(containerOrderItems, offeringsToAdd, customerMarketsIds);
            OrderItemHelper.addTopOffersToSO(salesOrder, ruleResult, offeringsToAdd, customerMarketsIds);

            List<OrderItem> addedOrderItems = getOrderItems(salesOrder.getOrderItemsAsList(), offeringsToAdd);

            OrderItemHelper.fillCharacteristics(salesOrder,addedOrderItems);
            //and for children
            for (OrderItem addedOrderItem : addedOrderItems) {
                OrderItemHelper.fillCharacteristics(salesOrder,addedOrderItem.getOrderItemsAsList());
            }
        }
        LOGGER.info("Finished execution of adding offering");
    }

     */
}
