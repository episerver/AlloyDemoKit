using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace AlloyDemoKit.Business.Employee
{
    public class DataGenerator
    {
        readonly string[] names = new string[200] { "Lester Love", "Johnny Jefferson", "Vanessa Phelps", "Cora Patrick", "Susan Copeland", "Ida Weaver", "Pedro Roy", "Shelly Moran", "Gina Armstrong", "Nick Smith", "Erin Campbell", "Alonzo Thornton", "Maxine Wade", "Dawn Gregory", "Samuel Porter", "Ian Gibbs", "Sherry King", "Lindsey Johnson", "Shawn Weber", "Kelvin Price", "Rodney Pittman", "Brad Casey", "Josephine Duncan", "Nichole Morgan", "Francisco Reese", "Nathaniel Powers", "Ernestine Watkins", "Elvira Mullins", "Roderick Valdez", "Jackie Lawson", "Carlos Fleming", "Tim Franklin", "Margie Kim", "Herman Gilbert", "Suzanne Hanson", "Austin Maxwell", "Jonathon Ruiz", "Christine Reeves", "Jaime Nunez", "Angelica Goodwin", "Debra Little", "Janice Francis", "Tommie Lawrence", "Patsy Holloway", "Roxanne Hodges", "Kay Larson", "Eloise Tucker", "Della Williams", "Jessie Lopez", "Christie Rodriguez", "Kristina Thomas", "Johnnie Goodman", "Melvin Medina", "Rex Fields", "Patricia Ford", "Oliver Horton", "Warren Summers", "Tommy Nelson", "Ruben Marshall", "Joyce Nguyen", "Eunice Jensen", "Caleb Turner", "Evan Berry", "Loretta Gill", "Manuel Wells", "Elaine Brady", "Sheri Chapman", "Johnnie Ball", "Darren Glover", "Maria Hart", "Samantha Ramirez", "Jean Allen", "Donald Fernandez", "Clyde Curtis", "Javier Ortiz", "Claude Rios", "Ray Bryant", "Shirley Walters", "Elmer Rowe", "Taylor Patton", "Bertha Lloyd", "Byron Shaw", "Sheila Garza", "Darlene Graham", "Pauline Miller", "Sarah French", "Kristy Pierce", "Jean Hardy", "Kristin Rivera", "Jim Fox", "Timmy Munoz", "Lee Matthews", "Alfredo Harris", "Francis Vega", "Traci Castillo", "Becky Pratt", "Carolyn Reed", "Israel Dawson", "Kent Cannon", "Joan Austin", "Trinidad Alley","Glenna Driver","Idell Canfield","Dedra Arreola","Gaylene Ybarra","Jillian Bautista","Junior Kirkpatrick","Gearldine Roldan","Lane Vallejo","Jinny Bales","Aron Sandlin","Dorene Lerner","Ophelia Wilhelm","Alva Findley","Tiesha Hinson","Aleen Cupp","Brady Cintron","Trisha Freedman","Edward Mansfield","Teresia Girard","Domenic Hassell","Ryan Devlin","Herschel Baughman","Jospeh Zaragoza","Edgardo Branch","Leesa Burris","Gerda Mello","Carissa Trimble","Dalene Connell","Otha Lassiter","Lamonica Halsey","Florentino Lemke","Everette Jernigan","Alene Coombs","Karine Butts","Inger Quiroz","Sanda Burnett","Maragaret Winstead","Tarsha Delaney","Kai Chestnut","Julianne Church","Tenisha Hurtado","Donya Walls","Thuy Herzog","Alease Boyle","Shonta Dupree","Mariel Choi","Moira Labbe","Avery Whatley","Giuseppina Fong","Rodrigo Reagan","Kandice Rupp","Margit Hathaway","Kenyetta Joy","Markus Nevarez","Aaron Hennessey","Deandre Currier","Madelyn Soliz","Joye Travis","Ima Lehman","Romelia Griswold","Fabiola Rizzo","Zofia Wheatley","Cristal Devito","Thomas Pedersen","Jolene Guerin","Miquel Spaulding","Rosanne Derrick","Cari Belanger","Rubin Li","Nikia Elder","Mia Goble","Catarina Tubbs","Sandee Mathews","Kazuko Jacobsen","Rhea Cardona","Minna Hulsey","Willian Dickerson","Lakesha Rutledge","Taina Ferrari","Raelene Coronado","Zita Kirk","Corinna Osorio","Lyndon Valadez","Hiram Rigby","Roberto Cavazos","Savannah Noyes","Omer Garnett","Phylis Smyth","Sherell Marrero","Leisa Harrell","Louie Zeigler","Twana Hopper","Clelia Buffington","Treasa Word","Dee Leone","Miyoko Langford","Kasi Barney","Federico Peak","Odis Swan" };
        const string number = "(0)207 555 5555";
        private const string description = "{0} is a {1} in the {2} group in {3}.<p> {4} acts for clients on complex projects that require a degree of detail and knowledge in this field. They have worked both locally and internationally on various projects. </p><p> {4} has worked for corporations in the {5} sectors to successful conclusions for our clients.</p>";
        readonly string[] jobs = new string[12] { "Partner", "Sales Associate", "Account Executive", "Marketing Manager", "COO", "CEO", "CTO", "CMO", "Director", "Project Manager", "Technology Associate", "Human Resources Administrator" };
        readonly string[] locations = new string[26] { "Abu Dhabi", "Nairobi", "Beijing", "Brussels", "Frankfurt", "Hong Kong", "Cape Town", "Jakarta", "Dubai", "Los Angeles", "Mumbai", "San Paulo", "London", "Madrid", "Munich", "New York", "Paris", "Chicago", "Rome", "Moscow", "Shanghai", "Singapore", "Stockholm", "Sydney", "Tokyo", "Washington DC" };
        readonly string[] allExpertise = new string[36] { "Software","UX","Banking","Capital markets","Commercial contracts","Commodities","EU law and consumer protection","Construction","Corporate","Design and UI","Data protection and privacy","Human Resources","Energy and resources","Environment","Finance","Compliance","Healthcare","Hotels and leisure", "Gaming","Infrastructure","Insurance","Intellectual property","Investment funds","Planning","Project management","Public sector and government","Real estate","Tax","Technology, media and telecommunications","Transport","Leisure and entertainment","Food and beverage","Retail","E-commerce","Manufacturing","Clothing" };
        readonly string[] images = new string[5] { "/globalassets/content/contact-portraits/fionamiller.jpg", "/globalassets/content/contact-portraits/AmarGupta.jpg", "/globalassets/content/contact-portraits/MichelleHernandez.jpg", "/globalassets/content/contact-portraits/ToddSlayton.jpg", "/globalassets/content/contact-portraits/RobertCarlson.jpg" };
        const string TabDelimiter = "\t";
        Random rnd;

        public void GenerateExpertiseFile(string fileName)
        {
            WriteFileByNewLine(fileName, allExpertise);
        }

        public void GenerateLocationsFile(string fileName)
        {
            WriteFileByNewLine(fileName, locations);
        }

        public void GenerateDataFile(string fileName)
        {
            rnd = new Random();
            using (var writer = File.CreateText(fileName))
            {

                foreach (string name in names)
                {
                    string[] row = new string[10];

                    // ID
                    row[0] = RandomNumber(9999, 100).ToString();
                    // Names
                    int space = name.IndexOf(" ");
                    string fName = name.Substring(0, space);
                    string lName = name.Substring(space + 1);
                    row[1] = fName;
                    row[2] = lName;
                    // Phone
                    row[3] = number;
                    // Email
                    row[4] = name.Replace(' ', '.') + "@episerver.alloy.com";
                    // Title
                    row[5] = jobs[RandomNumber(12)];
                    // Location
                    row[6] = locations[RandomNumber(26)];
                    // Expertise
                    string firstExpertise = string.Empty;
                    row[7] = ConstructExpertise(out firstExpertise);
                    // Description
                    row[8] = string.Format(description, name, row[5], firstExpertise, row[6], fName, row[7]);
                    // Image
                    row[9] = images[RandomNumber(5)];

                    writer.WriteLine(String.Join(TabDelimiter, row));
                }

                writer.Close();

                System.Threading.Thread.Sleep(999);
            }
        }

        private void WriteFileByNewLine(string fileName, string[] array)
        {
            using (var writer = File.CreateText(fileName))
            {
                array.ToList().ForEach(x => writer.WriteLine(x));
                writer.Close();
            }
        }
        private string ConstructExpertise(out string firstItem)
        {
            int totalExpertise = RandomNumber(10, 1);
            List<string> expertiseList = new List<string>(totalExpertise);

            for (int i = 1; i <= totalExpertise; i++)
            {
                bool added = false;

                do
                {
                    string expertise = allExpertise[RandomNumber(36)];
                    if (!expertiseList.Contains(expertise))
                    {
                        expertiseList.Add(expertise);
                        added = true;
                    }
                } while (added == false);
            }

            firstItem = expertiseList.First();

            return string.Join(",", expertiseList);
        }

        private int RandomNumber(int max, int min = 0)
        {
            return rnd.Next(min, max);
        }
    
    }
}