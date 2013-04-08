using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using Jqueryeasyui3.Model;

namespace Jqueryeasyui3
{
    /// <summary>
    /// Summary description for save_user
    /// </summary>
    public class save_user : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string firstname = context.Request.Form["firstname"];
            string lastname = context.Request.Form["lastname"];
            string phone = context.Request.Form["phone"];
            string email = context.Request.Form["email"];


            mydbEntities1 db = new mydbEntities1();

            user p = new user();
            p.firstname = firstname;
            p.lastname = lastname;
            p.phone = phone;
            p.email = email;

            db.AddTousers(p);
            db.SaveChanges();

            var p1 = new result();

            if (p != null)
            {
                p1.success = true;
                p1.msg = "aaa";               
                              
            }
            else
            {
                p1.success = false;
                p1.msg = "Some errors occured.";
                
            }

            DataContractJsonSerializer json = new DataContractJsonSerializer(p1.GetType());
            json.WriteObject(context.Response.OutputStream, p1);
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