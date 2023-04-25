SET LINES 1000 PAGES 3000
SET TRIMS ON
SPOOL df_yes_optiktv_logs.txt

/**** YES YES YES OPTIK TV Tax Included Offer YES YES YES ****/
DECLARE
    cnt NUMBER := 0;
    v_code  NUMBER;
    v_errm  VARCHAR2(64);

    TYPE NumberArrayType IS TABLE of NUMBER;
    NumArray NumberArrayType := NumberArrayType 
    (
        9165890934668160764,9162265729018768079,9160675422113633759,9161299933685665401,9162232936472639225,9152222432213217102,9152222433213217106,9152222433213217118,
        9152222433213217122,9160752422913919210,9162241461136637331,9162320949211982013,9160752517013919215,9162241486767639357,9160005339513179707,9160005340313179776,
        9160132066213290541,9160132136213290750,9162232988910637127,9162241252962637326,9162241261790639355,9162241319441639356,9166055230922079632,9160005340313179786,
        9160005341013179876,9162241421751637328,9162241441863637329,9162241510023637332,9162241532532637333,9162241549350637334,9162241612047637335,9152222433213217126,
        9152222433213217130,9162241644274639359,9162241679340637336,9162320098822982009,9162320099792982010,9153470497413288012,9153478355313293548,9153470300013287887,
        9153470455413288007,9153478226013293433,9153478307913293443,9156379487513076192,9156379764213076543,9149675349313098013,9150995295613502264,9151228215313652387,
        9159034270813379370,9159034273213379375,9159034275913379380,9164783177314235043,9162610807525427147,9165891654624163187,9164975419168891101,9163030499813769045,
        9164242065757077264,9164309042579777651,9164491240758317025,9164498270593317055,9165856897352131420,9165856830375039337,9162615597433739407,9161171348013609890,
        9165145528305320760,9165821575179039291,9161776951687502399,9165857886577039345,9165948681714777937,9164921610457303457,9164930482568891015,9165856945155131423,
        9164689012757653890,9164691478662619735,9164604426362174764,9164922995962320235,9164750982537855176,9164650468098174932,9164691056576619734,9164692500847653898,
        9156308353513082456,9159061859413921939,9153524728213325467,9153525269113326000,9161212543313215210,9162530900809703223,9153525538913326126,9156669604313700561,
        9153525616213326251,9153524078813320842,9151925168213290663,9159598242113794638,9159600232613820810,9159600431313822841,9159606108013847114,9163428896759709590,
        9163428944029442748,9163428987712517612,9163429024800442749,9164610982404174861,9164719346459619761,9164777106809855309,9164777281181855310,9164799062136279253,
        9164740030005693088,9165052283636320609,9162861745797619725,9166122663355039095,9162727544363155265,9159600431513822943,9159606108113847170,9160132066213290440,
        9160132136213290745,9163410578268517435,9163428845797442747,9164627743206675440,9164777146675693293,9164781139708855326,9164797754406882383,9165052845330320612,
        9166054415580079622,9166054443040079624,9164776977234235028,9164650957141317618,9153470373013287997,9153478279113293438,9154269108313836597,9154269181713943982,
        9154269123413836602,9154269137413878742,9154269165513936377,9154269190613948191,9155583197813200502,9155584511113202032,9150082892113470197,9150082897313470202,
        9150165510513181625,9150227969213138041,9150227989913138046,9150227997613138051,9150228008113138060,9150228008113138064,9150228008113138068,9150228008113138072,
        9150468786113165624,9150469247113165869,9150479612613177867,9150491353813183521,9150491370613183526,9150491380313183531,9150491388613183536,9150491396713183541,
        9150491405313183546,9150491413513183551,9150491449613183556,9150503369813190197,9150581005113199605,9150581302913199748,9150581402513199863,9150581803313199975,
        9150597646013199819,9150629626113217856,9150653065113246402,9150653112913246474,9150657344113250217,9150691369313385768,9150691977513387850,9150691993913387867,
        9150692230013388127,9150692241213388252,9150692260713388267,9150692286213388298,9150692332013388421,9150692471913389345,9150748122513689548,9150859068113491885,
        9150873728713503304,9150883296913509004,9150996223813502850,9151471753413316850,9151472752313318033,9151480264613323491,9151480287113323566,9151480546413324321,
        9151523884313376043,9151524216413376943,9151531282213382048,9151541282413400865,9151541561313401739,9151548505513407143,9151594006313899490,9151594067313899500,
        9151731816513649427,9151738806913653687,9151739974313657557,9151858580413218162,9151919141413284909,9151954376413313676,9152094914213012143,9152101635513017834,
        9152562042813041043,9152697798213574208,9152698419413574843,9152703633413141150,9152757945113639922,9152915282713768581,9152915333713768735,9152940697513788743,
        9153008998513871072,9153009502613871568,9153034575213892618,9153034575613892704,9153034680013893321,9153035016713893544,9153035660513896127,9153035678213896213,
        9153041876513397092,9153256727113860059,9153415739413981480,9153491243713303884,9153523767213320529,9153553057413151729,9153585182213373609,9153619974913455378,
        9153647364313470569,9153653337313473541,9153822878313680477,9153974740713607375,9153983722513615406,9154252954313818259,9154253029913818328,9154253096113818501,
        9154253222013818613,9154268662113836263,9154331122213968768,9154425778113505341,9154560597613899784,9154764355213439906,9155352401713907498,9155521888013234114,
        9155531799513040847,9155583023113200347,9155584511013201952,9155607456013390718,9155711127113468341,9155711146713468658,9155726660413478671,9155726667913478796,
        9155728708613482179,9155771776113907970,9155777902413910694,9155882804513436549,9155945582613488468,9155952154013995011,9156100635613171250,9156255393713992893,
        9156299503913068790,9156377023113145652,9156379487413076112,9156379764113076463,9156392952813161967,9156401799213170771,9156557631913300455,9156632120913667272,
        9156632836713668091,9156695606713458145,9156704137713464719,9157576502913103239,9157593175613121292,9158024255213028887,9158024672213029233,9158205992413673889,
        9158665922513039019,9158675548313043746,9158678710413045555,9158678872313045692,9158679368613046317,9158679520113046621,9158765335413615509,9158765506713623911,
        9158920855013764698,9158922833013765953,9159076223013145262,9159333657713146350,9159342468813152912,9159598242113794766,9159600232613820792,9159600431213822823,
        9159606108013847096,9159997856013960074,9160003113513174753,9160004396413177347,9160005339513179703,9160005340313179781,9160005341013179905,9160007108313181668,
        9160008778713185468,9160132066213290528,9160132136213290735,9160481232013744982,9160489138413753288,9160740793513913127,9160756980013921961,9160757696113960800,
        9160758398113923978,9160758855913924406,9160760348513925483,9160760623013925851,9160778640613972179,9160783800713938480,9160790936213983513,9160793781213985518,
        9160793807913985767,9160795262713988820,9160795421013989040,9161290921613794857,9161327925313818809,9161344547513790880,9161940047213013962,9161940240813014696,
        9161940915813017135,9161941002913017238,9161941099013017764,9161942150113022914,9161949961966434555,9163030499237653776,9163030991225769051,9163031395801653785,
        9163045690469415162,9163135403190084660,9163135659177061363,9163144803358084738,9163279587523581231,9163340868003699844,9163685685887622520,9164921609947303451,
        9164930482046891011,9165102978863891409,9165145254321304007,9165162482201376784,9165163618841376794,9165648252971056108,9165690875913639441,9165027326960303727,
        9164739851309855041,9160407039813932476,9159076222913145232
    );

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    SAVEPOINT before_datafix;
    FOR i IN 1..NumArray.count LOOP

        DBMS_OUTPUT.PUT_LINE(' ');
        /*** NO Alteration Price Component Validation ***/
        SELECT COUNT(*) INTO cnt  FROM nc_objects nco WHERE parent_id = NumArray(i);
        IF cnt = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| NumArray(i) ||' Does NOT have Price Alteration Component AND is Optik TV -> SKIPED');
            CONTINUE;
        END IF;


        /* Promo has TIC Promotion Category? */
        SELECT COUNT(*) INTO cnt FROM nc_references WHERE 
        attr_id = 9153770145313318210   /* ATTR_ID : Promotion Type */
        AND
        reference = 9153779179813323603 /* REFERENCE :  Tax Included Credits */ 
        AND
        object_id = NumArray(i);

        /* NO: Promo doesnt have TIC Promotion Category */
        IF cnt = 0 THEN
            
            /* INSERT REFERENCE TO TIC PROMO CATEGORY */ 
            INSERT INTO nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type)
            VALUES
            ( 
                9153770145313318210, /* ATTR_ID : Promotion Type */                
                9153779179813323603, /* REFERENCE :  Tax Included Credits */
                NumArray(i),
                6,
                0,
                0
            );
            DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| NumArray(i) ||' INSERTED reference to Tax Included Credits');
        END IF;

        /* Price Alteration has referece to tax code? */
        SELECT COUNT(*) INTO cnt FROM nc_references 
        WHERE attr_id = 9142883780313111933  /* ATTR_ID: Tax Code */ 
        AND object_id = (SELECT object_id  FROM nc_objects nco WHERE parent_id = NumArray(i));

        /*NO: INSERT REFERENCE TO 9998 */
        IF cnt = 0 THEN
            INSERT INTO  nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type)
            VALUES
            (
                9142883780313111933, /* Tax Code attr */
                9164799782513550301, /* 9998 ref */
                (SELECT object_id  FROM nc_objects nco WHERE parent_id = NumArray(i)), /* Alteration Price Component */
                1,
                0,
                0
            );
            DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| NumArray(i) ||' INSERTED reference to Tax Code 9998 since is an OPTIK TV Promo');

        /*YES: UPDATE REFERENCE TO 9998 */
        ELSE
            UPDATE nc_references SET 
            reference = 9164799782513550301 /* 9998 ref*/
            WHERE
            attr_id = 9142883780313111933   /* Tax Code attr */
            AND 
            object_id = (SELECT object_id  FROM nc_objects nco WHERE parent_id = NumArray(i)); /* Alteration Price Component */
            DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| NumArray(i) ||' UPDATED reference to Tax Code 9998 since is an OPTIK TV Promo');

        END IF;
        DBMS_OUTPUT.PUT_LINE('Promotion object_id: '|| NumArray(i) ||' Successfully Updated');
    END LOOP;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before_datafix;
        DBMS_OUTPUT.PUT_LINE('E X C E P T I O N');
        v_code := SQLCODE;
        v_errm := SUBSTR(SQLERRM, 1, 64);
        DBMS_OUTPUT.PUT_LINE (v_code || ' ' || v_errm);
END;
/

SPOOL OFF