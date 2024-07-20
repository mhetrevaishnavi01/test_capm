using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(

    // UI.SelectionFields:[
    // PO_ID,
    // CURRENCY_code,
    // GROSS_AMOUNT,
    // OVERALL_STATUS,
    // PARTNER_GUID.EMAIL_ADDRESS
    // ],
    UI.LineItem:[
        {
        $Type:'UI.DataField', 
        Value:PO_ID
        } ,
        {
        $Type:'UI.DataField',
        Value:PARTNER_GUID.EMAIL_ADDRESS
        },
        {
            $Type:'UI.DataField',
            Value:GROSS_AMOUNT
        },
         {
            $Type:'UI.DataFieldForAction',
            Action:'CatalogService.boost',
            Label:'boost',
            Inline:true
        },
        {
            $Type:'UI.DataField',
            Value:OverallStatus,
            Criticality:ColorCode
        }

    ],
    UI.HeaderInfo:{ //for heading
        TypeName:'PurchaseOrder',
         TypeNamePlural:'Purchase Orders' ,
         Title:{Value : PO_ID},
         Description:{Value : PARTNER_GUID.COMPANY_NAME}   
    },

UI.Facets  : [
    {
$Type : 'UI.CollectionFacet',
Label:'General Information',
Facets:[
    {
        $Type:'UI.ReferenceFacet',
        Label:'Order Details',
        Target:'@UI.Identification'
    },
    {
$Type:'UI.ReferenceFacet',
Label:'Configuration details',
Target:'@UI.FieldGroup'
    }
   
]
    },

      {
        $Type:'UI.ReferenceFacet',
        Label:'Table items',
        Target:'Items/@UI.LineItem' //association with items and annotate is below defined
    },
    
    
] ,

UI.Identification:[
    {
      $Type:'UI.DataField',
      Value:PO_ID
    },
    {
     $Type:'UI.DataField',
      Value:PARTNER_GUID_NODE_KEY
    },
    {
      $Type:'UI.DataField',
      Value:OVERALL_STATUS
    }

],
UI.FieldGroup:{
    Label:'Pricing',
    Data:[
    {
         $Type:'UI.DataField',
      Value:GROSS_AMOUNT
    },
    {
        $Type:'UI.DataField',
      Value:NET_AMOUNT
    },
    {
        $Type:'UI.DataField',
      Value:TAX_AMOUNT
    },
      {
        $Type:'UI.DataField',
      Value:CURRENCY_code
    }
    ]
}

);

annotate service.POItems with @(

  UI.LineItem:[   
     {
      $Type:'UI.DataField',
      Value: PARENT_KEY_NODE_KEY
    } ,
     {
      $Type:'UI.DataField',
      Value: PRODUCT_GUID.CATEGORY
    } ,
     {
      $Type:'UI.DataField',
      Value: PRODUCT_GUID.TYPE_CODE
    },
  ],
  UI.HeaderInfo: {
  TypeName: 'PO_ITEM',
  TypeNamePlural:'PO_Items',
  Title:{Value:PO_ITEM_POS},
  Description:{Value:PRODUCT_GUID.DESCRIPTION}
  },

  UI.Facets:[
    {
      $Type:'UI.ReferenceFacet',
       Label:'MORE INFORMATION',
       Target:'@UI.Identification'
    }
  ],
  UI.Identification:[
    {
$Type:'UI.DataField',
Value:PO_ITEM_POS
    },
    {
$Type:'UI.DataField',
Value:PRODUCT_GUID_NODE_KEY
    },
  ]
 
  
  


);