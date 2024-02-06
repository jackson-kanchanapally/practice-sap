namespace com.test.sdb;
using {cuid} from '@sap/cds/common';
@assert.unique:{
    userId:[userId]
}
entity User :cuid {
    @title:'userId'
    userId:String(5);
    @title:'name'
    name: String(30);
    @title:'email'
    email: String(30);
    Options:Composition of many{
          key ID: UUID;
        opt :Association to Options;
    }
}
entity Options : cuid {
        @title:'code'
    code:String(5);
    @title:'des'
    des: String(30);
}
entity Admin : cuid {
    @title:'adminId'
    adminId:String(5);
    @title:'role'
    role: Association to  Role;
}
entity Role: cuid {

        @title:'code'
    code:String(5);
    @title:'des'
    des: String(30);
}
