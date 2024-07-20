using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSView';
 
 
service CatalogService @(path: 'CatalogService') {
 
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
    //@readonly //controlling entitysets
    //@Capabilities : { Deletable: false }
   entity EmployeeSet as projection on master.employees;
    entity POs @(odata.draft.enabled : true) as projection on transaction.purchaseorder{
        *, //* means all the fields of  purchaseorder entity and items means association
        Items ,
        case OVERALL_STATUS 
        when 'P' then 'pending'
        when 'A' then 'Approved'
        when 'X' then 'rejected'
        when 'N' then 'New'
          end as OverallStatus : String(32),

        case OVERALL_STATUS
        when 'P' then 1
        when 'N' then 1
        when 'A' then 3
        when 'X' then 2
        end as ColorCode: Integer

        
        
    }
actions{
    @Common.SideEffects:{ //when boost is clciked groos amount should be increasesd
        $Type:'Common.SideEffectsType',
        TargetProperties:[
            'in/GROSS_AMOUNT',
        ]
    }
        action boost() returns POs

}
entity POItems as projection on transaction.poitems;
function largestOrder() returns POs; //its non instance bound material

}