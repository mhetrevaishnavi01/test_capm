namespace ust.vaish;
using { ust.reuse as reuse } from './reuse';
using { cuid,managed,temporal } from '@sap/cds/common';

context master{
    //type Guid : String(40);

entity student:reuse.Address{
key id : reuse.Guid;
name : String(80);
age : Int16;
class: Association to semester;
    }
    entity semester{
        key id:reuse.Guid;
        name :String(30);
        specialization: String(80);
        hod: String(40);
    }
  
    entity books{
        key code:reuse.Guid;
        name : localized String(30);
        author: String(80);
     }
        

}

context Transaction{
    entity sub:cuid,managed,temporal{
        student : Association to one master.student;
        book : Association to master.books;
    }
}
