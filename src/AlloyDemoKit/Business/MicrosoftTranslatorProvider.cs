using EPiServer.Framework.Localization;
using EPiServer.Logging;
using System;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Net.Http;

namespace EPiServer.Labs.LanguageManager.Business.Providers
{
    public class MicrosoftTranslatorProvider : IMachineTranslatorProvider
    {
        private static readonly ILogger _logger = LogManager.GetLogger();
        private static string headerEntryWithAccessToken = string.Empty;

        public string DisplayName
        {
            get
            {
                return "Microsoft Translator Text API";
            }
        }

        public bool Initialize(string consumerKey, string consumerSecret)
        {
            if (string.IsNullOrWhiteSpace(consumerKey))
            {
                _logger.Error("Consumer key has not been provided.");
                return false;
            }

            var token = new AzureAuthToken(HttpUtility.UrlEncode(consumerKey.Trim()));

            try
            {
                headerEntryWithAccessToken = token.GetAccessToken();
            }
            catch (HttpRequestException)
            {
                if (token.RequestStatusCode == HttpStatusCode.Unauthorized)
                {
                    _logger.Error("Request to token service is not authorized (401). Check that the Azure subscription key is valid.");
                    return false;
                }
                if (token.RequestStatusCode == HttpStatusCode.Forbidden)
                {
                    _logger.Error("Request to token service is not authorized (403). For accounts in the free-tier, check that the account quota is not exceeded.");
                    return false;
                }
                throw new OperationCanceledException(); ;
            }
            return true;
        }




        public bool Translate(string inputText, string fromLang, string toLang, out string outputText)
        {
            bool flag = false;
            if (string.IsNullOrWhiteSpace(inputText))
            {
                outputText = string.Empty;
                return flag;
            }

            string uri = string.Format($"http://api.microsofttranslator.com/v2/Http.svc/Translate?text={HttpUtility.UrlEncode(inputText)}&from={fromLang}&to={toLang}");
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(uri);
            httpWebRequest.Headers.Add("Authorization", headerEntryWithAccessToken);
            WebResponse webResponse = null;
            try
            {
                using (WebResponse response = httpWebRequest.GetResponse())
                using (Stream stream = response.GetResponseStream())
                {
                    DataContractSerializer dcs = new DataContractSerializer(Type.GetType("System.String"));
                    outputText = (string)dcs.ReadObject(stream);
                    flag = true;
                }
            }
            catch (Exception ex)
            {
                headerEntryWithAccessToken = string.Empty;
                outputText = "MICROSOFT_TRANSLATOR_ERROR";
                string str = string.Empty;
                //WebException webException;
                //if (ex is WebException && webException.Response != null)
                //{
                //    using (HttpWebResponse response = (HttpWebResponse)webException.Response)
                //    {
                //        using (StreamReader streamReader = new StreamReader(response.GetResponseStream()))
                //            str = streamReader.ReadToEnd();
                //    }
                //}
                _logger.Error(string.Format($"{str}. Cannot translate with Mircosoft Translator Text API, input={inputText}, fromLang={fromLang}, toLang={toLang}"), ex);
            }
            finally
            {
                if (webResponse != null)
                    webResponse.Close();
            }
            return flag;
        }
    }
}
