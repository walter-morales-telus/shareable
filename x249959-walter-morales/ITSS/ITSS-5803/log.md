
[//]: # (::::::::::::::: :::::::::::: ::::::::: :::::: ::: ITSS-5803 ::: :::::: ::::::::: :::::::::::: :::::::::::::::)
# <https://jira.tsl.telus.com/browse/FNDA-34113>
#### https://github.com/telus/taft-centralized/tree/dev/walter-morales/TAFT/x249959-walter-morales/ITSS/ITSS-5803
### Summary: [DMT_E2E_ITN01] Wrong decomposition for move of in-flight customer for LWC

### Links:
- [Folder](/TAFT/x249959-walter-morales/ITSS/ITSS-5803)
- [Dev](/TAFT/x249959-walter-morales/ITSS/ITSS-5803/DEV)
- [Testing](/TAFT/x249959-walter-morales/ITSS/ITSS-5803/TESTING)
- [Dormant/Undormant](/TAFT/x249959-walter-morales/ITSS/ITSS-5803/DORMANT_UNDOR)
- [Backup](/TAFT/x249959-walter-morales/ITSS/ITSS-5803/BACKUP)

```
::::::::::::::: :::::::::::: ::::::::: :::::: ::: ::: ::: :::    H E A D E R    ::: ::: ::: ::: :::::: ::::::::: :::::::::::: :::::::::::::::

    ID: ITSS-5803
  ITSS: 
  DATE: 12/July/2023 TIME (14:13)

DEV_CR: 
DEV_BR: 

::::::::::::::: :::::::::::: ::::::::: :::::: ↓↓↓ A L L   D E V E L O P M E N T   N O T E S ↓↓↓ :::::: ::::::::: :::::::::::: :::::::::::::::


HLD: https://docs.google.com/presentation/d/1qAi5nD1H_RXUFgDi_zueuUa1s4QQcnj4ScNZ9kYnoIQ/edit#slide=id.g2059b26aadc_2_858
     https://drive.google.com/drive/folders/1ETFq_kBlOP1Z8HbmnxE0jDVCcyFdVVKB



LivingWell Companion Home - Cellular
                                                                                    9161505363905984296
https://flcncapp-itn03.tsl.telus.com/common/uobject.jsp?tab=_Characteristics&object=9161505363905984296


CMS Provider Characteristic ---> 9157581860013018120
https://flcncapp-itn03.tsl.telus.com/ncobject.jsp?id=9157581860013018120

Rule:
Override CMS Provider value to Armstrong when LWC is New
https://flcncapp-itn03.tsl.telus.com/common/uobject.jsp?tab=_Rule+Info&object=9166530156011990022

Enable = NO
Modified to: Enable = Yes


//Check if a Characteristic is part of Custom Rule Parameter
select * from nc_objects o,
nc_references r
where object_type_id = 9146755276313217645 /* Reference Rule Parameter */
and
attr_id = 9146755329513217743 /* Value */
and
reference = 9157581860013018120 /* CMS Provider Characteristic */
and
o.object_id = r.object_id
order
by parent_id;

//Check if a Characteristic is part of Custom Rule Parameter
select * from nc_references where attr_id = 9146755329513217743 /* Value */  and reference in (9157581860013018120 /* CMS Provider Characteristic */);

select 
object_id 
from 
nc_references 
where 
attr_id = 9132975427813986236 /* 
Text Characteristic Value */  
and 
reference in (9161476340013742033 /* 100 Mbps */,9161476340013742022 /* 50 Mbps */)





```
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>







