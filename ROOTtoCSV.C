#include <TFile.h>
#include <TString.h>
#include <TTree.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <TTreePlayer.h>


void ROOTtoCSV(TString filename)
{

	TFile *f = new TFile(filename.Data()); 
	TTree *tree = (TTree*)f->Get(f->GetListOfKeys()->Last()->GetName()); 
	
	char txtOutputFile [250]; sprintf (txtOutputFile, "namesCSV.txt"); 
  	ofstream txtfile (txtOutputFile);
  	txtfile.setf(ios::fixed,ios::floatfield);  
  	txtfile.precision(16);
  	
  	Int_t num_branches = tree->GetNbranches();
  	TObjArray *listo = tree->GetListOfBranches();
  	
  	txtfile << "Row,";
  	for (Int_t i=0; i<num_branches; i++) {
  		if (i==(num_branches-1)) txtfile << listo->At(i)->GetName();
  		else txtfile << listo->At(i)->GetName() << ",";
  	}  	
  	txtfile << endl;
  
	((TTreePlayer*)(tree->GetPlayer()))->SetScanRedirect(true);
	((TTreePlayer*)(tree->GetPlayer()))->SetScanFileName("bulkCSV.txt");
	tree->Scan("*");
	
	txtfile.close();
	f->Close();
} 