using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.IO;


public class ChartImageDestructor
   {
      String fileName;
      public ChartImageDestructor(String fileName){
         this.fileName = fileName;
      }

      public void RemovedCallback(String k, Object v, CacheItemRemovedReason r){
         try{
            File.Delete(fileName);
         }
         catch {
         }
      }
   }



