/**** YES YES YES OPTIK TV Tax Included Offer YES YES YES ****/
DECLARE
    cnt NUMBER := 0;
    v_code  NUMBER;
    v_errm  VARCHAR2(64);

    markets    varchar2(500) := 'empty';
    categories varchar2(500) := 'empty';
    promotypes varchar2(500) := 'empty';

    promoname varchar2(500)  := 'empty';

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    FOR iter IN (select object_id from nc_objects where object_type_id = 9133383350013199423) LOOP

        /*** NO Alteration Price Component Validation ***/
        SELECT COUNT(*) INTO cnt  FROM nc_objects nco WHERE parent_id = iter.object_id;
        IF cnt = 0 THEN 
            /*DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| iter.object_id ||' Does NOT have Price Alteration Component AND is Optik TV -> SKIPED');*/
            CONTINUE;
        END IF;

        /* O N L Y   T W O */
        SELECT COUNT(*) INTO cnt FROM nc_references WHERE
        attr_id = 9153770145313318210   /* ATTR_ID : Promotion Type */
        AND
        (
        reference = 9153779179813323603 /* REFERENCE :  Tax Included Credits */
        OR
        reference = 9153779179813323599 /* Discounts */
        )
        AND
        object_id = iter.object_id;

        /* S K I P */
        IF cnt < 2 THEN
            CONTINUE;
        END IF;
        

        select nco.name into promoname from nc_objects nco where object_id = iter.object_id;

        /* P R O M O T I O N   T Y P E */
        for itype in 
        (
            SELECT nco.name FROM nc_references ncr, nc_objects nco WHERE
            ncr.attr_id = 9153770145313318210   /* ATTR_ID : Promotion Type */
            AND
            ncr.reference = nco.object_id
            AND
            ncr.object_id = iter.object_id
        ) loop

            IF (promotypes = 'empty') THEN
                promotypes := itype.name;
            ELSE
                promotypes := promotypes ||';     '||itype.name;
            END IF;

        end loop;

        /* M A R Q U E T */
        for imar in 
        (
            select
            ncr.object_id,
            ncotwo.name as promotion,
            nco.name    as market

            from
            nc_references ncr,
            nc_objects    nco,
            nc_objects    ncotwo

            where ncr.object_id = iter.object_id
            and
            ncr.object_id = ncotwo.object_id
            and
            ncr.reference = nco.object_id
            and
            ncr.attr_id = 9145610709013180878 /* Market */
        ) loop

            IF (markets = 'empty') THEN
                markets := imar.market;
            ELSE
                markets := markets ||';     '||imar.market;
            END IF;

        end loop;


        /* C A T E G O R Y */
        for icat in 
        (
            select
            ncr.object_id,
            ncotwo.name as promotion,
            nco.name    as category

            from
            nc_references ncr,
            nc_objects    nco,
            nc_objects    ncotwo

            where ncr.object_id = iter.object_id
            and
            ncr.object_id = ncotwo.object_id
            and
            ncr.reference = nco.object_id
            and
            ncr.attr_id = 9145610709013180882 /* Customer Category*/
        ) loop

            IF (categories = 'empty') THEN
                categories := icat.category;
            ELSE
                categories := categories ||';     '||icat.category;
            END IF;
            
        end loop;

        dbms_output.put_line(iter.object_id||','||promoname||','||promotypes||','||markets||','||categories);

        promoname  := 'empty';
        promotypes := 'empty';
        markets    := 'empty';
        categories := 'empty';

    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('E X C E P T I O N');
        v_code := SQLCODE;
        v_errm := SUBSTR(SQLERRM, 1, 64);
        DBMS_OUTPUT.PUT_LINE (v_code || ' ' || v_errm);
END;
/




/*
https://stackoverflow.com/questions/37858281/how-to-store-a-column-of-result-of-select-query-in-an-array
Number iter.object_idation
*/












