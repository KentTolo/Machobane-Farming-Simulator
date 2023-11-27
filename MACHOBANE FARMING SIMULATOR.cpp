/*
========================================================================

Authors	•	Liteboho Maseli – 202101659
		•	Hlalele Manganye – 202101681
		•	Khoase Hashatsi – 202101671
		•	Hlalefang Makhasane – 202002398
		•	Keketso Tolo – 202100092		
Date: 25 November 2023 
File Name: MACHOBANE FARMING SYSTEM FINAL APK.cpp

========================================================================
 */

#include <iostream>
using namespace std;


const int Field_row = 20;
const int Field_col = 20; 

struct Crop
{
    char cropSymbol [50];
    int plantingMonth;
    int harvestingStartMonth;
    int harvestingEndMonth;
};

using Matrix = Crop[Field_row][Field_col];
void menu()
{
	cout << "==============================================" << endl;
    cout << "           Machobane Farming System  " << endl;
    cout << "==============================================" << endl;
    cout << "1. Seasonal crop Management " << endl;
    cout << "2. Soil fertility and moisture management " << endl;
    cout << "3. Crop yeild "<<endl;
    cout << "4. Exit " << endl;
};

void plantCrops(Matrix A_Field,int curr_Month) 
{
	int row;
	cout<<"Enter number of lines to plant : \n"<<endl;
	cin>>row;
	for(int i=0;i < row;i++)
	{
		for(int j=0;j < Field_col;j++)
		{
			cout<<"Enter crop symbol: \n";
			cin>>A_Field[i][j].cropSymbol;
      		A_Field[i][j].plantingMonth = curr_Month;
			cout<<"Enter harvesting start Month: \n";
			cin>>A_Field[i][j].harvestingStartMonth;
			cout<<"Enter harvesting end Month : \n";
			cin>>A_Field[i][j].harvestingEndMonth;
		}
	}
};

void harvestCrops(Matrix A_Field,int current_Month)
{
	for(int i=0;i <Field_row;i++)
	{
		for(int j=0;j < Field_col;j++)
		{
			if(current_Month == (A_Field[i][j].harvestingStartMonth||A_Field[i][j].harvestingEndMonth))
			{
				cout<<A_Field[i][j].cropSymbol;
				cout<<A_Field[i][j].plantingMonth;
				cout<<current_Month;
			}
			else
			{
				cout<<"No plants available for harvest"<<endl;
			}
		}
	}
};

void intercropRelayCrop(Matrix A_Field)
{
	int row;
	cout<<"Enter number of lines to plant : \n"<<endl;
	cin>>row;
	for(int i=0;i < row;i++)
	{
		for(int j=0;j<Field_col;j++)
		{
			cout<<"Enter change symbol to plant "<<endl;
			cout<<"Enter crop symbol: \n";
			cin>>A_Field[i][j].cropSymbol;
			cout<<"Enter planting Month: \n";
			cin>>A_Field[i][j].plantingMonth;
			cout<<"Enter harvesting start Month: \n";
			cin>>A_Field[i][j].harvestingStartMonth;
			cout<<"Enter harvesting end Month: \n";
			cin>>A_Field[i][j].harvestingEndMonth;
		}
	}
};

void manageSoil( )
{
	int moisture_sensor, acidity_sensor;
    cout << "Enter the moisture of the soil: " << endl;
    cin >> moisture_sensor;
    cout << "Enter the acidity of the soil: " << endl;
    cin >> acidity_sensor;
  	// the suitable moisture for most plant crops 41%-80% moisture 
  	// The soil fertility will be determined by the soil pH, which will be 6.0-6.5
        if (6.0<=acidity_sensor<=6.5)
        {
          cout << "Soil is fertile."<<endl;
        }
         else 
        {
           cout << "Adjust soil fertility by adding some fertilizer \n"<<endl;;
  
        }
  	if (0.41<=moisture_sensor<=0.8)
    {
      cout << "Moisture is good "<<endl;
    }
  	else 
    {
      cout << "Adjust moisture " <<endl;
    }
};

void calculateYield(Matrix A_Field)
{
	int n,m, acidity_sensor, moisture_sensor;
	cout<<"Enter number of lines to plant: \n";
	cin>>n;
    cout<<"Enter number of crops : \n";
    cin>>m;
	cout << "Enter the moisture of the soil: " << endl;
    cin >> moisture_sensor;
    cout << "Enter the acidity of the soil: " << endl;
    cin >> acidity_sensor;
    double yieldFactor=1.0; 
    yieldFactor *= acidity_sensor;
    yieldFactor *= moisture_sensor;
    for(int i= 0;i < n;i++)
	{
    	for(int j=0;j < m;j++)
		{
			int growthPeriod = A_Field[i][j].harvestingEndMonth - A_Field[i][j].plantingMonth; 
			if(growthPeriod > 1 && A_Field[i][j].plantingMonth % 2 == 0)
			{
           		yieldFactor *= 1.1;  
			}
         double yieldFinal = growthPeriod * yieldFactor;
         cout<<"Yield For" << A_Field[i][j].cropSymbol << ":" << yieldFinal << "tons" << endl;
    	}
	}
};


int main()
{
	int choice;
	Matrix A_Field;
	
	do
	{
		menu();
		cin>>choice;
		switch (choice)
		{
			
			case 1:
				//Print seasonal crop management menu
			int choice2;	
			cout<<"--------------------------------"<<endl;	
			cout<<"Seasonal crop Management"<<endl;
			cout<<"--------------------------------"<<endl;
    		cout<<"1. Winter  Crops "<<endl;
    		cout<<"2. Summer  Crops "<<endl;
    		cout<<"3. Relay   Crop  "<<endl;
    		cout<<"4. Harvest Crops "<<endl;
    		cout<<"5. Exit "         <<endl; 
    		cin>>choice2;
    		switch(choice2)
    		{
    			case 1:
    				cout <<"YOU ARE IN THE WINTER PLANTING SESSION" <<endl;
    				cout << "---------------------------------" << endl;
    				cout << " Winter Crops " << endl;
    				cout << "---------------------------------" << endl;
    				cout << " [+]  wheat" << endl;
    				cout << " [&]  peas" << endl;
    				cout << " [@] Potatoes\n" << endl;
    				cout << "Choose symbol that represents crop type" <<endl;
    				int curr_month;
					cout<<"Enter current month: \n";
					cin>>curr_month;
              		if(4<=curr_month<=5 )
					{
						plantCrops(A_Field,curr_month);
					}
					else
					{
               	 		cout<<"Can not plant, not yet time"<<endl;
               	 	}
    				
    				break;
    				
    			case 2:
					cout <<"YOU ARE IN THE SUMMER PLANTING SESSION" <<endl;
    				cout << "---------------------------------" << endl;
    				cout << "Summer Crops " << endl;
    				cout << "---------------------------------" << endl;
    				cout << " [!] - beans" << endl;
    				cout << " [%] - pumpkin" << endl;
    				cout << " [#] - watermelon" << endl;
    				cout << " [^] - sorgum" << endl;
    				cout << " [0] - ground Nuts" << endl;
    				cout << " [*] - maize \n" << endl;	
    				int ycurr_month;
					cout<<"Enter current month: \n";
					cin>>ycurr_month;
              		if(8<=curr_month<=10)
              		{
						plantCrops(A_Field,curr_month);
				    }
              		else 
              		{
               			cout<<"Can not plant, not yet time"<<endl;
               		}
    				
    				break;
    				
    				case 3:
    					intercropRelayCrop(A_Field);
    					break;
    					
    				case 4:
    					int month_current;
    					cout<<"Enter current month: \n"<<endl;
    					cin>>month_current;
    					if(11<=month_current<=12 || 1<=month_current<=3)
						{
    						harvestCrops(A_Field, month_current);
						}
			}
			
			case 2:
				manageSoil();
				break;
			
			case 3:
				calculateYield(A_Field);
				break;
				
			case 4:
				break;		
		}
		
	}
	while(choice!=0);
	return 0;
}