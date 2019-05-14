using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        /// <summary>
        /// Lotter Details Sturcture, excluding the fields we do not need
        /// </summary>
        public struct LotteryDetails
        {
            public int drawNumber;
            public DateTime date;
            public List<int> winningNumbers;
            public int bonusNumber;
        }

        /// <summary>
        /// Holds a list of lottery details, making it easy to parse through
        /// </summary>
        public List<LotteryDetails> lotteryDetails = new List<LotteryDetails>();
        /// <summary>
        /// Lists all textboxes in page
        /// </summary>
        public List<TextBox> textboxes = new List<TextBox>();
        /// <summary>
        /// Dictionary that contains winnings as per given data.
        /// nothing below 4 wins, as they are not counted. we add 0.5 in case there is a bonus number match
        /// </summary>
        public Dictionary<float, int> winnings = new Dictionary<float, int>()
        {
            { 4,85 },
            { 5,3000 },
            { 5.5f,250000 },
            { 6,5000000 },
        };


        /// <summary>
        /// Initialization function, we put our initialization code here as this fires when the page loads. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Read the csv file stored along with the code. This implementation would change if the data source was dynamically changing
            string[] str = File.ReadAllLines(Server.MapPath("649.csv"));

            //Parse the csv file by splitting strings using comma as delimiter
            for (int i = 1; i < str.Length; i++)
            {
                string[] temp = str[i].Split(',');
                //Only consider draws where seq numbers was 0
                if (Convert.ToInt32(temp[2]) == 0)
                {
                    var tempLotteryDeets = new LotteryDetails
                    {
                        drawNumber = Convert.ToInt32(temp[1]),
                        date = DateTime.Parse(temp[3].Replace("\"", "")),
                        winningNumbers = new List<int>() { Convert.ToInt32(temp[4]), Convert.ToInt32(temp[5]), Convert.ToInt32(temp[6]), Convert.ToInt32(temp[7]), Convert.ToInt32(temp[8]), Convert.ToInt32(temp[9]) },
                        bonusNumber = Convert.ToInt32(temp[10])
                    };
                    //After parsing, save the lotter details into our 
                    lotteryDetails.Add(tempLotteryDeets);

                }

            }
            //Save texboxes in a list for easy reference as well.
            textboxes = new List<TextBox>() { TextBox1, TextBox2, TextBox3, TextBox4, TextBox5, TextBox6 };

        }

        //NOTE: Rest of the implementation code is in Default.aspx

    }
}