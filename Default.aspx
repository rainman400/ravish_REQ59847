<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script runat="server">
         private List<int> numbers = new List<int>();
        /// <summary>
        /// OnClick Function, handles tallying of winnings and final result display
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void ValidateBtn_OnClick(object sender, EventArgs e)
        {
            TextboxForAnswer.Text = "";
            if (Page.IsValid && DuplicateValidationAndNumberListFilling())
            {
                int totalWin = 0;
                int totalSpend = 0;
                //Go through each lottery winning number combination
                for(int i = 0; i < lotteryDetails.Count; i++)
                {
                    float matchCount = 0;
                    bool bonusMatch = false;
                    //Verify how many, if any, numbers matched, including bonus number
                    for(int j = 0; j < numbers.Count; j++)
                    {
                        //Check for match
                        if(lotteryDetails[i].winningNumbers.Contains(numbers[j]))
                        {
                            matchCount++;
                        }
                        //Check for bonus number match
                        if(numbers[j] == lotteryDetails[i].bonusNumber)
                        {
                            bonusMatch = true;
                        }

                        //Add money spent based on draw number
                        if(lotteryDetails[i].drawNumber < 2125)
                        {
                            totalSpend += 1;
                        }
                        else if(lotteryDetails[i].drawNumber < 2990)
                        {
                            totalSpend += 2;
                        }
                        else
                        {
                            totalSpend += 3;
                        }
                    }

                    //Only display if total matches was greater than 3, because 4 onwards they win $85
                    if(matchCount > 3)
                    {
                        //on matching 5 is the only place bonus number counts
                        if(matchCount == 5 && bonusMatch)
                        {
                            matchCount += 0.5f;
                        }
                        TextboxForAnswer.Text += lotteryDetails[i].date.ToString("dd/MM/yyyy") + " won: $" + String.Format("{0:0,0.0}",winnings[matchCount]) +"\n";
                        totalWin += winnings[matchCount];
                    }
                }
                TextboxForAnswer.Text += "---------\n";
                TextboxForAnswer.Text += "Total Won: $" + String.Format("{0:0,0.0}",totalWin)+"\n";
                TextboxForAnswer.Text += "You Spent: $" + String.Format("{0:0,0.0}",totalSpend)+"\n";
                var difference = totalWin - totalSpend;
                TextboxForAnswer.Text += "Net won/loss: $" + String.Format("{0:0,0.0}", (difference < 0? "("+Math.Abs(difference).ToString()+")":difference.ToString()))+"\n";
            }

            else
            {
                TextboxForAnswer.Text += "Please fix errors and try again!";
            }
            
        }

        /// <summary>
        /// Checks if the textbox contains a NUMBER between 1-49 and is not blank. Empty check is done by the Customvalidators attached to each textbox. 
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        void NumberValidation(object source, ServerValidateEventArgs args)
        {
            try
            {
                if (!string.IsNullOrEmpty(args.Value))
                {
                    int i = int.Parse(args.Value);
                    args.IsValid = (i > 0 && i <= 49);
                }
                else
                {
                    TextboxForAnswer.Text += "Enter numbers in all boxes \n";
                    args.IsValid = false;
                }
            }

            catch(Exception ex)
            {
                args.IsValid = false;
            }

        }
        /// <summary>
        /// Checks duplicate numbers in the boxes, also fills the number list. 
        /// </summary>
        /// <returns></returns>
        bool DuplicateValidationAndNumberListFilling()
        {
            foreach(TextBox tBox in textboxes)
            {
                var boxNumber = Convert.ToInt32(tBox.Text);
                if(!numbers.Contains(boxNumber))
                {
                    numbers.Add(boxNumber);
                }
                else
                {
                    TextboxForAnswer.Text += "Duplicate Numbers! Too many "+boxNumber.ToString()+". Remove the one at box #"+textboxes.IndexOf(tBox)+1+  "?\n\n";
                    return false;
                }
            }
            return true;
        }
    </script>

    <div >
        <h1>Welcome to the Code Challenge Solution</h1>
        <p>Enter six numbers (between 1 and 49) below and we will check them against every 6/49 draw since 1981, and calculate your net winnings (or losings)</p>

        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox1" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator1" runat="server"  ControlToValidate="TextBox1" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox2" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator2" runat="server"  ControlToValidate="TextBox2" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox3" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator3" runat="server"  ControlToValidate="TextBox3" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox4" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator4" runat="server"  ControlToValidate="TextBox4" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox5" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator5" runat="server"  ControlToValidate="TextBox5" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
        <div style="height: 113px; width: 70px" class = "displayInline">
        <asp:TextBox ID="TextBox6" runat="server" Height="71px" Width="65px"></asp:TextBox>
                <br />
                <asp:CustomValidator ID="CustomValidator6" runat="server"  ControlToValidate="TextBox6" ForeColor="Red" ErrorMessage="NUMBER between 1 - 49 please" OnServerValidate="NumberValidation" ValidateEmptyText="True"></asp:CustomValidator>
            </div>
            
</div>

        <asp:Button id="Button1" runat="server" Text="Click To Check now!" OnClick="ValidateBtn_OnClick"/>
        <div style="height: 198px">
            <asp:Textbox ID="TextboxForAnswer" runat="server" Text=" " Height="279px" ReadOnly="True" TextMode="MultiLine" Width="425px"></asp:Textbox>
        </div>

</asp:Content>
