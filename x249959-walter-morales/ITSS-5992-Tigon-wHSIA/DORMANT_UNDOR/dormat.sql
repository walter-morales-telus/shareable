/* Apply Dormancy 5992 */

update nc_params
set list_value_id = 5032957201013871254 /* No */
where attr_id     = 7030253282013155504 /* Is Active */
and object_id in (
    9166546284978458697, /* 5G Indoor Router - Easy Payment Replacement */
    9166554407100411231, /* 5G Indoor Router - One Time Replacement */
    9166562827695682815, /* 5G Outdoor Router - Easy Payment Replacement */
    9166565565845411269, /* 5G Outdoor Router - One Time Replacement */
    9166566063516411270, /* TELUS Wi-Fi Hub - Easy Payment Replacement */
    9166605727440198978, /* TELUS Wi-Fi Hub - One Time Replacement */
    9166684593193199149, /* $10/24 months & Equipment Promo (RNW) */
    9166675595171199141  /* wHSIA Promotion Rule for Commitment ($10 off for 24 months RNW) */
);

update nc_params
set list_value_id = 5032957201013871249 /* Yes */
where attr_id     = 7030253282013155504 /* Is Active */
and object_id in (
    9163688663289824539 /* Add Wireless HSIA Connection Fee when upgrade to higher speed and change from IDU to ODU */
);

update nc_params
set list_value_id = 5032957201013871254 /* No */
where attr_id     = 7030253282013155504 /* Is Active */
and object_id in (
    9166614790469199017, /* 5G IDU Easy Pay Replacement 'Conflicts With' 5G IDU One Time Replacement */
    9166608637511682856, /* 5G ODU Easy Pay Replacement 'Conflicts With' 5G ODU One Time Replacement */
    9166614453350682876, /* TWH Easy Payment Replacement 'Conflicts With' TWH One Time Replacement */
    9166675155242199140, /* 5G IDU Category 'Conflicts With' 5G ODU Category */
    9166718277713854270, /* [WHSIA] Hide wHSIA Equipment Replace Offers During Provide */
    9166893674855421916
    
);
