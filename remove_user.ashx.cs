﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Runtime.Serialization.Json;
using Jqueryeasyui3.Model;

namespace Jqueryeasyui3
{
    /// <summary>
    /// Summary description for remove_user
    /// </summary>
    public class remove_user : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int id = Convert.ToInt32(context.Request["id"]);
           
            mydbEntities1 db = new mydbEntities1();

            user new1 = db.users.Single(u => u.id == id);
           
            db.DeleteObject(new1);
            db.SaveChanges();

            var p1 = new result();

            if (new1 != null)
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