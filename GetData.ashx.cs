using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization.Json;
using Jqueryeasyui3.Model;

namespace Jqueryeasyui3
{
    /// <summary>
    /// Summary description for GetData
    /// </summary>
    public class GetData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var Re = new ReturnDate();

            mydbEntities1 db = new mydbEntities1();

            var query = from p in db.users

                        select p;

            List<person> new1 = new List<person>();

            foreach (var q in query)
            {
                person p1 = new person();
                p1.id = q.id;
                p1.firstname = q.firstname;
                p1.lastname = q.lastname;
                p1.phone = q.phone;
                p1.email = q.email;
                new1.Add(p1);
            }

            Re.total = new1.Count.ToString();
            Re.rows = new1;

            DataContractJsonSerializer json = new DataContractJsonSerializer(Re.GetType());
            json.WriteObject(context.Response.OutputStream, Re);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}