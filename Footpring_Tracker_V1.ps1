
#Program Requirements & Dependencies
# ShowUI Must be downloaded and installed
# SHowUI is used in the HELP Page
# ShowUI can be downloaded at: http://showui.codeplex.com/
# Example of how SHOWUI can be used: http://www.drdobbs.com/windows/building-gui-applications-in-powershell/240049898


# Create the form
# We must load two .NET classes:
#	System.Drawing
#	System.Windows.Forms

	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 



#Modules to import
#ShowUI is used in HelpPage
	import-Module ShowUI

#Added functionality for outputting EDM search data to DialogBox output

	function HelpPage
		{
			Show-UI {
			   StackPanel -Margin 10 -Children {
				  TextBlock "Footprint Tracker Help Page" -FontSize 42 -FontWeight Bold #-Foreground "#ff9400" 
				  #Background = "orange"
				  
				  TextBlock -FontSize 24 -Inlines {
					 Bold "Question: "
					 "Do you want to leave us feedback? "
					 Hyperlink "Click for Developer Page" -NavigateUri https://github.com/ForensicTools/FootprintTracker-475-2161_Mendello_Rana `
											 -On_RequestNavigate { [Diagnostics.Process]::Start( $this.NavigateUri.ToString() ) }
				  }
TextBlock -FontSize 16 -Inlines {
Span -FontSize 24 -FontWeight Bold -Inlines "Project Purpose:"
"
The purpose of this program is simple, to provide the typical user
a free and simple solution to finding out what their windows based 
computer knows about them. This will be a free tool geared for the
average joe computer user, moms and dads etc."}
			}
			}
		}	



		
	function WindowsForm
		{
			# Now we can instantiate a new instance of the .NET Framework class System.Window.Forms.Form
			#	This will present the blank form (window) that we can add controls to
				$objForm = New-Object System.Windows.Forms.Form 


			#Now that we have an instance of the Form class we can then assign values to three properties of this class:
			#	Text - Disregard the name, this is actually the window title.
			#	Size - This is the size of the form, in pixels. In our case, we're creating a form that's 500 pixels wide by 300 pixels tall.
			#	StartingPosition - This is option; if this property is left out, Windows will pick a location to use when displaying this form. 
			#					   By setting the StartingPosition to CenterScreen our form will automatically be displayed in the middle of the screen each time it loads.
				$objForm.Text = "Footprint Tracker"
				$objForm.Size = New-Object System.Drawing.Size(500,300) 
				$objForm.StartPosition = "CenterScreen"
				
				# Background color
				# https://msdn.microsoft.com/en-us/library/system.drawing.color(v=vs.110).aspx
				$objForm.BackColor = "DarkOrange"
				
				

				# https://blogs.technet.microsoft.com/stephap/2012/04/23/building-forms-with-powershell-part-1-the-form/
				
				
			# Here we are configuring our form to perform two things:
			#	1) Use the ENTER key instead of OK button.
			#	2) Use the ESC key instead of the Cancel button.
			<#
			In order to do this we first set the KeyPreview 
			property to true ($True); that tells the form to 
			intercept specific keystrokes rather than allow those 
			keystrokes to be used by the controls on the form. 
			What keystrokes do we want to capture? You got it: the ENTER 
			key and the ESC (Escape) key. Notice the syntax for capturing a 
			keystroke
			#>

				$objForm.KeyPreview = $True
				$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
					{$x=$objTextBox.Text;$objForm.Close()}})
				$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
					{$objForm.Close()}})
		
		
			Buttons
			MainMenuLabels
			MenuInput
			
		
		}
		


	function Buttons
	{
		$checkBox1 = New-Object System.Windows.Forms.CheckBox
		$checkBox1.Location = New-Object System.Drawing.Point(300,125)
		$checkBox1.Size = New-Object System.Drawing.Size(145,24)
		$checkBox1.UseVisualStyleBackColor = $True
		$checkBox1.TabIndex = 0
		$Font = New-Object System.Drawing.Font("Times New Roman",11,[System.Drawing.FontStyle]::Bold)
		$checkBox1.Font = $Font
		$checkBox1.Text = "Create Report"
		$checkBox1.DataBindings.DefaultDataSourceUpdateMode = 0
		$checkBox1.Name = "checkBox1"
		$objForm.Controls.Add($checkBox1)
	
	
	
	
		$SubmitButton = New-Object System.Windows.Forms.Button
		$SubmitButton.Location = New-Object System.Drawing.Size(200,230)
		$SubmitButton.Size = New-Object System.Drawing.Size(75,23)
		$SubmitButton.Text = "Submit"
		$SubmitButton.Add_Click({$x=$objTextBox.Text;$objForm.Close()})
		$objForm.Controls.Add($SubmitButton)

		
		$ExitButton = New-Object System.Windows.Forms.Button
		$ExitButton.Location = New-Object System.Drawing.Size(275,230)
		$ExitButton.Size = New-Object System.Drawing.Size(75,23)
		$ExitButton.Text = "Exit"
		$ExitButton.Add_Click({$objForm.Close()})
		$objForm.Controls.Add($ExitButton)

		
		$AboutButton = New-Object System.Windows.Forms.Button
		$AboutButton.Location = New-Object System.Drawing.Size(400,5)
		$AboutButton.Size = New-Object System.Drawing.Size(75,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Italic)
		$AboutButton.Font = $Font
		$AboutButton.Text = "Help"
		$AboutButton.Add_Click({HelpPage})
		$objForm.Controls.Add($AboutButton)

		
		$BrowserPasswordButton = New-Object System.Windows.Forms.Button
		$BrowserPasswordButton.Location = New-Object System.Drawing.Size(10,50)
		$BrowserPasswordButton.Size = New-Object System.Drawing.Size(280,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Regular)
		$BrowserPasswordButton.Font = $Font
		$BrowserPasswordButton.Text = "1) Recover Passwords........................................................."
		$BrowserPasswordButton.Add_Click({BrowserPasswords|Out-GridView})
		$objForm.Controls.Add($BrowserPasswordButton)

		
		$BrowserHistory = New-Object System.Windows.Forms.Button
		$BrowserHistory.Location = New-Object System.Drawing.Size(10,75)
		$BrowserHistory.Size = New-Object System.Drawing.Size(280,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Regular)
		$BrowserHistory.Font = $Font
		$BrowserHistory.Text = "2) Internet Browser History........................................................."
		$BrowserHistory.Add_Click({})
		# Still working this^ out, something wrong with the BrowserPasswords function
                $objForm.Controls.Add($BrowserHistory)

		$EDMSearch = New-Object System.Windows.Forms.Button
		$EDMSearch.Location = New-Object System.Drawing.Size(10,100)
		$EDMSearch.Size = New-Object System.Drawing.Size(280,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Regular)
		$EDMSearch.Font = $Font
		$EDMSearch.Text = "3) Exact Data Matching (EDM) ......."
		$EDMSearch.Add_Click({$textboxEDM.Text = searchFilesEDM})
		# Got this working by piping output to a DialogBox with GridView upon a button click
                $objForm.Controls.Add($EDMSearch)


		$PatternMatching = New-Object System.Windows.Forms.Button
		$PatternMatching.Location = New-Object System.Drawing.Size(10,125)
		$PatternMatching.Size = New-Object System.Drawing.Size(280,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Regular)
		$PatternMatching.Font = $Font
		$PatternMatching.Text = "4) Pattern Matching..........................."
		$PatternMatching.Add_Click({})
		$objForm.Controls.Add($PatternMatching)
		

		$RunEverything = New-Object System.Windows.Forms.Button
		$RunEverything.Location = New-Object System.Drawing.Size(10,150)
		$RunEverything.Size = New-Object System.Drawing.Size(280,26)
		# Font styles are: Regular, Bold, Italic, Underline, Strikeout
		$Font = New-Object System.Drawing.Font("Times New Roman",14,[System.Drawing.FontStyle]::Regular)
		$RunEverything.Font = $Font
		$RunEverything.Text = "5) Run everything......................................"
		$RunEverything.Add_Click({})
		$objForm.Controls.Add($RunEverything)
		
	}


	function MainMenuLabels
	{
		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(10,20) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "Please Enter Operation Number"
		$objForm.Controls.Add($objLabel) 


	}

	function MenuInput
	{
		$objTextBox = New-Object System.Windows.Forms.TextBox 
		$objTextBox.Location = New-Object System.Drawing.Size(140,210) 
		$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
		$objForm.Controls.Add($objTextBox) 	
		
		
		
		#Set the Topmost property to $false to NOT force the window to open atop other open windows and dialog boxes.
		$objForm.Topmost = $False
		$objForm.Add_Shown({$objForm.Activate()})
		[void] $objForm.ShowDialog()
	}	





	function searchFilesEDM
		{
			Get-ChildItem -recurse | Select-String -pattern "David" | group path | select name | Out-GridView

		}




# list out all of the entries in the Credential Manager
# http://www.toddklindt.com/blog/Lists/Posts/Post.aspx?ID=606

	function BrowserPasswords
		{
			$FileName = "Browser_Passwords"
			[void][Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
			$vault = New-Object Windows.Security.Credentials.PasswordVault 
			$vault.RetrieveAll() | % { $_.RetrievePassword();$_ } | Out-Gridview
			# $vault.RetrieveAll() | % { $_.RetrievePassword();$_ } | Export-CSV -Path "$home\Desktop\BrowserPasswords.csv"
		}



	
WindowsForm

# Source: https://technet.microsoft.com/en-us/library/ff730941.aspx





