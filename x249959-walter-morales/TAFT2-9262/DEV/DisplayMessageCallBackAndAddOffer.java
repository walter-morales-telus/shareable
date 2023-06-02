package com.netcracker.ncportal.telus.rules;

import com.netcracker.businessoe.api.entities.OrderItem;
import com.netcracker.businessoe.api.entities.SalesOrder;
import com.netcracker.businessoe.api.entities.catalog.ProductOfferingCategory;
import com.netcracker.businessoe.api.entities.catalog.rules.ProductOfferingRule;
import com.netcracker.businessoe.api.entities.catalog.rules.RuleElement;
import com.netcracker.businessoe.rule.expression.CustomClassExpression;
import com.netcracker.businessoe.rule.expression.ExpressionProcessorParamKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.netcracker.businessoe.rule.result.RuleResult;
import com.netcracker.businessoe.api.entities.catalog.ProductOffering;
import com.netcracker.businessoe.controllers.OrderItemAction;

import java.math.BigInteger;
import java.util.*;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.collect.Lists.newArrayList;
import static com.netcracker.businessoe.rule.expression.ExpressionProcessorParamKey.*;
import static com.netcracker.ncportal.generic.rules.helper.GeneralRuleHelper.*;
import static java.util.Collections.emptyList;

public class DisplayMessageCallBackAndAddOffer implements CustomClassExpression<Boolean> {

    private static final Logger LOGGER = LoggerFactory.getLogger(DisplayMessageCallBackAndAddOffer.class);


    private static final String YES_BUTTON = "YesButton";
    private static final String NO_BUTTON = "NoButton";
    private static final String YES_ACTION = "Yes";
    private static final String CANCEL_ACTION = "No";
    private static final String YES_ACTION_PCI_ID = "0";
    private static final String CANCEL_ACTION_PCI_ID = "1";
    private static final String OFFER_TO_ADD = "Offer to add";
    private static final String CATEGORY_FOR_CONTAINER = "Category for container";

    private static final BigInteger MESSAGE_SHOWN_FAKE_CHAR_ID= BigInteger.valueOf(-9162492914213767913L);

    private static final Map<String, String> actions = new HashMap<String, String>() {{
        put(YES_ACTION, YES_ACTION_PCI_ID);
        put(CANCEL_ACTION, CANCEL_ACTION_PCI_ID);
    }};


    @Override
    public Boolean execute(Map<String, Object> params) {
        ProductOfferingRule rule = (ProductOfferingRule) params.get(ExpressionProcessorParamKey.PRODUCT_OFFERING_RULE);

        if (isCallBack(params)) {
            return executeRuleCallBackAction(params, rule);
        } else {
            return executeRule(params, rule);
        }
    }

    private boolean executeRule(Map params, ProductOfferingRule rule) {
        LOGGER.info("Start DisplayMessageCallBackAndAddOffer rule action for rule with id: {}.", rule.getId());
        RuleElement ruleElement = checkNotNull((RuleElement) params.get(RULE_ELEMENT), "Rule element is absent in custom action params.");
        ruleElement.setMessage(rule.getMessage());
        ruleElement.setRuleActions(actions);
        LOGGER.info("End DisplayMessageCallBackAndAddOffer rule action for rule with id: {}, return true and show message.", rule.getId());
        return true;

    }

    private boolean executeRuleCallBackAction(Map params, ProductOfferingRule rule) {
        LOGGER.info("Start DisplayMessageCallBackAndAddOffer rule callback action for rule with id: {}.", rule.getId());
        String callbackAction = checkNotNull((String) params.get(RULE_CALLBACK_ACTION), "Callback action id is absent in custom action callback params.");
        if (YES_ACTION_PCI_ID.equals(callbackAction)) {
            addOffer(params);
            LOGGER.info("End DisplayMessageCallBackAndAddOffer rule callback action for rule with id: {}, YES button, return true.", rule.getId());
            return true;
        } else if (CANCEL_ACTION_PCI_ID.equals(callbackAction)) {
            processCancelClick(params);
            LOGGER.info("End DisplayMessageCallBackAndAddOffer rule callback action for rule with id: {}, No button, return false.", rule.getId());
            return true;
        } else throw new IllegalArgumentException("Unexpected callback action id: " + callbackAction);
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

    private void processCancelClick(Map params) {
        //nothing
    }

}
