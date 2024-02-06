using {com.test.sdb as db} from '../db/schema';

service UserDb {
    entity User as projection on db.User;
    entity Options as projection on db.Options
    {
         @UI.Hidden : true
        ID,
        * 
    };
    entity Admin as projection on db.Admin;
    entity Role as projection on db.Role
    {
         @UI.Hidden : true
        ID,
        * 
    };
};
annotate UserDb.User with @odata.draft.enabled;
annotate UserDb.Options with @odata.draft.enabled;
annotate UserDb.Admin with @odata.draft.enabled;

annotate UserDb.User.Options with @(
    UI.LineItem:[
        {
            Value:opt_ID
        }
    ],
    UI.FieldGroup #OptionUser:{
        $Type:'UI.FieldGroupType',
        Data:[
              {
            Value:opt_ID
        },
        ],
    },
    UI.Facets:[
            {
        $Type :'UI.ReferenceFacet',
        ID : 'OptionUserFacet',
        Label : 'OptionUser',
        Target : '@UI.FieldGroup#OptionUser',
    },
    ]
);
annotate UserDb.Options with @(
    UI.LineItem:[
        {
            Value:code,
        },
        {
            Value:des,
        }
    ],
    UI.FieldGroup #Option: {
        $Type: 'UI.FieldGroupType',
        Data : [
        {
            Value:code,
        },
        {
            Value:des,
        }

        ],
    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'OptionsFacet',
            Label:'Options facets',
            Target:'@UI.FieldGroup#Option'
        },
    ],
);
annotate UserDb.Role with @(
    UI.LineItem:[
        {
            Value:code,
        },
        {
            Value:des,
        }
    ],
);
annotate UserDb.User with @(
    UI.LineItem        : [
        {Value: userId},
        {Value: name},
        {Value: email},
        {Value: Options.opt.code},
    ],
    UI.FieldGroup #User: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: userId},
            {Value: name},
            {Value: email},
        ],

    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'UserFacet',
            Label:'user facets',
            Target:'@UI.FieldGroup#User'
        },
        {
            $Type:'UI.ReferenceFacet',
            ID:'OptionsFacet',
            Label:'option user facets',
            Target:'Options/@UI.LineItem'
        },
    ],
);
annotate UserDb.Admin with @(
    UI.LineItem        : [
        {Value: adminId},
        {Value: role.des},
        
    ],
    UI.FieldGroup #Admin: {
        $Type: 'UI.FieldGroupType',
        Data : [
     {Value: adminId},

      {
        Label:'role',
        Value: role_ID},
        ],

    },
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'AdminFacet',
            Label:'Admin facets',
            Target:'@UI.FieldGroup#Admin'
        },
    ],
);


annotate UserDb.User.Options with {
    opt @(
        Common.Text: opt.des,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Options',
            CollectionPath : 'Options',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : opt_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'des'
                },
            ]
        }
    );
}
annotate UserDb.Admin with {
    role @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Role',
            CollectionPath : 'Role',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : role_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },

                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'des'
                },
            ]
        }
    );
}

