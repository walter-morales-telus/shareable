/* Promo has TIC Promotion Category? */
SELECT * FROM nc_references WHERE
/* ATTR_ID : Promotion Type */
attr_id = 9153770145313318210
AND
/* REFERENCE :  Tax Included Credits */
reference = 9153779179813323603
AND
object_id = 9164921610457303457;



/* INSERT REFERENCE TO TIC PROMO CATEGORY */ 
INSERT INTO nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type)
VALUES
(
    9153770145313318210, /* ATTR_ID: Promotion Type */ 
    9153779179813323603, /* REFERENCE:  Tax Included Credits */
    9164921610457303457,
    2,
    0,
    0
);

INSERT INTO  nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type)
VALUES
(
    9142883780313111933, /* Tax Code attr */
    9164799782513550301, /* 9998 ref */
    /* Alteration Price Component */
    (SELECT object_id  FROM nc_objects nco WHERE parent_id = 9164921610457303457),
    1,
    0,
    0
);

UPDATE nc_references SET 
reference = 9164799782513550301 /* 9998 ref*/
WHERE
attr_id = 9142883780313111933   /* Tax Code attr */
AND 
object_id = (SELECT object_id  FROM nc_objects nco WHERE parent_id = 9164921610457303457);



/* 9999 ref*/
/* 9153786500813327277 */

9159439016913219855