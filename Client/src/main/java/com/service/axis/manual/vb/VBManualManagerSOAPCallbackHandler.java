
/**
 * VBManualManagerSOAPCallbackHandler.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.7.9  Built on : Nov 16, 2018 (12:05:37 GMT)
 */

    package com.service.axis.manual.vb;

    /**
     *  VBManualManagerSOAPCallbackHandler Callback class, Users can extend this class and implement
     *  their own receiveResult and receiveError methods.
     */
    public abstract class VBManualManagerSOAPCallbackHandler{



    protected Object clientData;

    /**
    * User can pass in any object that needs to be accessed once the NonBlocking
    * Web service call is finished and appropriate method of this CallBack is called.
    * @param clientData Object mechanism by which the user can pass in user data
    * that will be avilable at the time this callback is called.
    */
    public VBManualManagerSOAPCallbackHandler(Object clientData){
        this.clientData = clientData;
    }

    /**
    * Please use this constructor if you don't want to set any clientData
    */
    public VBManualManagerSOAPCallbackHandler(){
        this.clientData = null;
    }

    /**
     * Get the client data
     */

     public Object getClientData() {
        return clientData;
     }

        
           /**
            * auto generated Axis2 call back method for getArticles method
            * override this method for handling normal response from getArticles operation
            */
           public void receiveResultgetArticles(
                    com.service.axis.manual.vb.VBManualManagerSOAPStub.GetArticlesResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from getArticles operation
           */
            public void receiveErrorgetArticles(java.lang.Exception e) {
            }
                
               // No methods generated for meps other than in-out
                
               // No methods generated for meps other than in-out
                
               // No methods generated for meps other than in-out
                
           /**
            * auto generated Axis2 call back method for getTopics method
            * override this method for handling normal response from getTopics operation
            */
           public void receiveResultgetTopics(
                    com.service.axis.manual.vb.VBManualManagerSOAPStub.GetTopicsResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from getTopics operation
           */
            public void receiveErrorgetTopics(java.lang.Exception e) {
            }
                
               // No methods generated for meps other than in-out
                
               // No methods generated for meps other than in-out
                
               // No methods generated for meps other than in-out
                
           /**
            * auto generated Axis2 call back method for getAuthor method
            * override this method for handling normal response from getAuthor operation
            */
           public void receiveResultgetAuthor(
                    com.service.axis.manual.vb.VBManualManagerSOAPStub.GetAuthorResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from getAuthor operation
           */
            public void receiveErrorgetAuthor(java.lang.Exception e) {
            }
                


    }
    