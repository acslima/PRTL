(* ::Package:: *)

BeginPackage["prtl`"]
(* 
Auxiliary functions for use with PRTL 
*)

MPot::usage = "Potential coefficients matrix"
S1::usage = "S1 function"
S2::usage = "S2 function"
T1::usage = "T1 function"
ZintTubo::usage = "Internal impedance for tubular conductors"
Zin::usage = "Internal inpedance for cylindrical conductors. Considering \[Mu]r=80 for steel cables"
ynlt::usage = ""

Begin["`Private`"]
MPot[x_?VectorQ,y_?VectorQ,nc_,npr_,rf_,rpr_]:=Table[If[i!=j,
1./2 Log[((x[[i]]-x[[j]])^2+(y[[i]]+y[[j]])^2)/((x[[i]]-x[[j]])^2+(y[[i]]-y[[j]])^2)],
If[i<=nc-npr,
Log[(2 y[[i]])/rf],
Log[(2 y[[i]])/rpr]]],{i,nc},{j,nc}]

S1[x_?VectorQ,y_?VectorQ,nc_,npr_,rf_,rpr_,\[Gamma]s_,\[Gamma]ar_]:=
With[{\[Eta]= Sqrt[\[Gamma]s^2-\[Gamma]ar^2]},
Table[If[i!=j,
Log[2./(\[Eta] Sqrt[(x[[i]]-x[[j]])^2+(y[[i]]+y[[j]])^2])+1],
If[i<=nc-npr,
Log[2/(\[Eta] Sqrt[4*y[[i]]^2+rf^2])+1],
Log[2/(\[Eta] Sqrt[4*y[[i]]^2+rpr^2])+1]]],{i,nc},{j,nc}]];

S2[x_?VectorQ,y_?VectorQ,nc_,npr_,rf_,rpr_,\[Gamma]s_,\[Gamma]ar_]:=
With[{n2=(\[Gamma]s/\[Gamma]ar)^2,\[Eta]= Sqrt[\[Gamma]s^2-\[Gamma]ar^2]},
2/(n2+1) Table[If[i!=j,
Log[1+(n2+1)/(\[Eta] Sqrt[(x[[i]]-x[[j]])^2+(y[[i]]+y[[j]])^2])],
If[i<=nc-npr,
Log[1+(n2+1)/(\[Eta] Sqrt[4*y[[i]]^2+rf^2])],
Log[1+(n2+1)/(\[Eta] Sqrt[4*y[[i]]^2+rpr^2])]]],{i,nc},{j,nc}]];

T1[x_?VectorQ,y_?VectorQ,nc_,npr_,rf_,rpr_,\[Gamma]s_,\[Gamma]ar_]:=
With[{n2=(\[Gamma]s/\[Gamma]ar)^2,\[Eta]= Sqrt[\[Gamma]s^2-\[Gamma]ar^2]},
2./(n2+1) Table[If[i!=j,
Log[(\[Eta] Sqrt[(x[[i]]-x[[j]])^2+(y[[i]]+y[[j]])^2]+n2+1)/(\[Eta] Sqrt[(x[[i]]-x[[j]])^2+(y[[i]]+y[[j]])^2]+2*n2+2)],
If[i<=nc-npr,
Log[(\[Eta] Sqrt[4*y[[i]]^2+rf^2]+n2+1)/(\[Eta] Sqrt[4*y[[i]]^2+rf^2]+2*n2+2)],
Log[(\[Eta] Sqrt[4*y[[i]]^2+rpr^2]+n2+1)/(\[Eta] Sqrt[4*y[[i]]^2+rpr^2]+2*n2+2)]]],{i,nc},{j,nc}]]

ZintTubo[Omega_,Rhoc_, rf_, rint_, Mur_: 1, Mu_: (4.*Pi)/10^7] := 
      Module[{r},  
       With[{Etac = N[Sqrt[(I*Omega*Mur*Mu)/Rhoc]],ri=rint+10^-6}, 
        With[{Den = BesselK[1,Etac*ri]*BesselI[1,Etac*rf]-BesselK[1,Etac*rf]*BesselI[1,Etac*ri], 
             Num =  BesselK[1,Etac*ri]*BesselI[0,Etac*rf]+BesselK[0,Etac*rf]*BesselI[1,Etac*ri]}, 
        ((Rhoc*Etac)*Num)/((2*Pi*rf)*Den)
        ]
       ]
      ];

Zin[Omega_, Rhopr_, rpr_, Mur_:80, Mu_:(4*Pi)/10^7] := 
    With[{Etapr = Sqrt[(I*Omega*Mu*Mur)/Rhopr]}, 
         ((Etapr*Rhopr)*BesselI[0, Etapr*rpr])/((2*Pi*rpr)*BesselI[1,Etapr*rpr])
         ];         

ynlt[Z_,Y_,length_]:=Module[{Z1=Z,Y1=Y,eval,evect,d,Tv,Tvi,hm,Am,Bm,y11,y12},{eval,evect}=Eigensystem[N[Z1.Y1]];
d=Sqrt[eval];
Tv=Transpose[evect];
Tvi=Inverse[Transpose[evect]];
hm=Exp[-d*length];
Am=d*(1+hm^2)/(1-hm^2);
Bm=-2.0*d*hm/(1-hm^2);
y11=N[Inverse[Z1]].Tv.DiagonalMatrix[Am].Tvi;
y12=N[Inverse[Z1]].Tv.DiagonalMatrix[Bm].Tvi;
{y11,y12}];

End[]

EndPackage[]
