data heart;
input id age sex cp trestbps chol fbs restecg thalach exang oldpeak slope ca thal num presence;
datalines;
1 63 1 4 140 260 0 1 112 1 3 2 . . 2 1
2 44 1 4 130 209 0 1 127 0 0 . . . 0 0
3 60 1 4 132 218 0 1 140 1 1.5 3 . . 2 1
4 55 1 4 142 228 0 1 149 1 2.5 1 . . 1 1
5 66 1 3 110 213 1 2 99 1 1.3 2 . . 0 0
6 66 1 3 120 0 0 1 120 0 -0.5 1 . . 0 0
7 65 1 4 150 236 1 1 105 1 0 . . . 3 1
8 60 1 3 180 0 0 1 140 1 1.5 2 . . 0 0
9 60 1 3 120 0 . 0 141 1 2 1 . . 3 1
10 60 1 2 160 267 1 1 157 0 0.5 2 . . 1 1
11 56 1 2 126 166 0 1 140 0 0 . . . 0 0
12 59 1 4 140 0 0 1 117 1 1 2 . . 1 1
13 62 1 4 110 0 0 0 120 1 0.5 2 . . 1 1
14 63 1 3 . 0 0 2 . . . . . . 1 1
15 57 1 4 128 0 1 1 148 1 1 2 . . 1 1
16 62 1 4 120 220 0 1 86 0 0 . . . 0 0
17 63 1 4 170 177 0 0 84 1 2.5 3 . . 4 1
18 46 1 4 110 236 0 0 125 1 2 2 . . 1 1
19 63 1 4 126 0 0 1 120 0 1.5 3 . . 0 0
20 60 1 4 152 0 0 1 118 1 0 . . . 0 0
21 58 1 4 116 0 0 0 124 0 1 1 . . 2 1
22 64 1 4 120 0 1 1 106 0 2 2 . . 1 1
23 63 1 3 130 0 0 1 111 1 0 . . . 3 1
24 74 1 3 . 0 0 0 . . . . . . 0 0
25 52 1 3 128 0 0 1 180 0 3 1 . . 2 1
26 69 1 4 130 0 1 1 129 0 1 2 . . 2 1
27 51 1 4 . 0 1 1 . . . . . . 2 1
28 60 1 4 130 186 1 1 140 1 0.5 2 . . 1 1
29 56 1 4 120 100 0 0 120 1 1.5 2 0 . 1 1
30 55 1 3 . 228 0 1 . . . . . . 3 1
31 54 1 4 . 0 0 1 . . . . . . 3 1
32 77 1 4 124 171 0 1 110 1 2 1 . . 3 1
33 63 1 4 160 230 1 0 105 1 1 2 . . 3 1
34 55 1 3 . 0 0 0 155 0 1.5 2 . . 3 1
35 52 1 3 122 0 0 0 110 1 2 3 . . 2 1
36 64 1 4 144 0 0 1 122 1 1 2 . . 3 1
37 60 1 4 . 281 0 1 . . . . . . 2 1
38 60 1 4 120 0 0 0 133 1 2 1 . . 0 0
39 58 1 4 . 203 1 0 . . . . . . 1 1
40 59 1 4 154 0 0 1 131 1 1.5 . 0 . 0 0
41 61 1 3 120 0 0 0 80 1 0 2 . . 3 1
42 40 1 4 125 0 1 0 165 0 0 . . . 1 1
43 61 1 4 . 0 1 1 86 0 1.5 2 . . 3 1
44 41 1 4 104 0 0 1 111 0 0 . . . 0 0
45 57 1 4 . 277 1 1 . . . . . . 4 1
46 63 1 4 136 0 0 0 84 1 0 . . . 2 1
47 59 1 4 122 233 0 0 117 1 1.3 3 . . 1 1
48 51 1 4 128 0 0 0 107 0 0 . . . 0 0
49 59 1 3 . 0 0 0 128 1 2 3 . . 2 1
50 42 1 3 134 240 . 0 160 0 0 . . . 0 0
51 55 1 3 120 0 0 1 125 1 2.5 2 . . 1 1
52 63 0 2 . 0 0 0 . . . . . . 0 0
53 62 1 4 152 153 0 1 97 1 1.6 1 . . 2 1
54 56 1 2 124 224 1 0 161 0 2 2 . . 0 0
55 53 1 4 126 0 0 0 106 0 0 . . . 1 1
56 68 1 4 138 0 0 0 130 1 3 2 . . 2 1
57 53 1 4 154 0 . 1 140 1 1.5 2 . . 2 1
58 60 1 3 . 316 1 1 . . . . . . 3 1
59 62 1 2 . 0 0 0 . . . . . . 0 0
60 59 1 4 178 0 1 2 120 1 0 . . . 1 1
61 51 1 4 . 218 1 2 . . . . . . 0 0
62 61 1 4 110 0 . 0 108 1 2 3 . . 2 1
63 57 1 4 130 311 . 1 148 1 2 2 . . 1 1
64 56 1 3 170 0 0 2 123 1 2.5 . . . 4 1
65 58 1 2 126 0 1 0 110 1 2 2 . . 2 1
66 69 1 3 140 0 . 1 118 0 2.5 3 . . 2 1
67 67 1 1 142 270 1 0 125 0 2.5 1 . . 3 1
68 58 1 4 120 0 0 2 106 1 1.5 3 . . 1 1
69 65 1 4 . 0 0 0 . . . . . . 1 1
70 63 1 2 . 217 1 1 . . . . . . 1 1
71 55 1 2 110 214 1 1 180 0 . . . . 0 0
72 57 1 4 140 214 0 1 144 1 2 2 . . 2 1
73 65 1 1 . 252 0 0 . . . . . . 0 0
74 54 1 4 136 220 0 0 140 1 3 2 . . 3 1
75 72 1 3 120 214 0 0 102 1 1 2 . . 3 1
76 75 1 4 170 203 1 1 108 0 0 . . . 1 1
77 49 1 1 130 0 0 1 145 0 3 2 . . 2 1
78 51 1 3 . 339 0 0 . . . . . . 3 1
79 60 1 4 142 216 0 0 110 1 2.5 2 . . 2 1
80 64 0 4 142 276 0 0 140 1 1 2 . . 1 1
81 58 1 4 132 458 1 0 69 0 1 3 . . 0 0
82 61 1 4 146 241 0 0 148 1 3 3 . . 2 1
83 67 1 4 160 384 1 1 130 1 0 2 . . 2 1
84 62 1 4 135 297 0 0 130 1 1 2 . . 2 1
85 65 1 4 136 248 0 0 140 1 4 3 . . 4 1
86 63 1 4 130 308 0 0 138 1 2 2 . . 2 1
87 69 1 4 140 208 0 1 140 1 2 . . . 3 1
88 51 1 4 . 227 1 1 . . . . . . 0 0
89 62 1 4 158 210 1 0 112 1 3 3 . . 1 1
90 55 1 3 . 245 1 1 . . . . . . 1 1
91 75 1 4 136 225 0 0 112 1 3 2 . . 3 1
92 40 1 3 106 240 0 0 80 1 0 . . . 0 0
93 67 1 4 120 0 1 0 150 0 1.5 3 . . 3 1
94 58 1 4 110 198 0 0 110 0 0 . . . 1 1
95 60 1 4 . 195 0 0 . . . . . . 0 0
96 63 1 4 160 267 1 1 88 1 2 . . . 3 1
97 35 1 3 . 161 0 1 . . . . . . 0 0
98 62 1 1 112 258 0 1 150 1 . . . . 1 1
99 43 1 4 122 0 0 0 120 0 0.5 1 . . 1 1
100 63 1 3 130 0 1 1 160 0 3 2 . . 0 0
101 68 1 3 150 195 1 0 132 0 0 . . . 1 1
102 65 1 4 150 235 0 0 120 1 1.5 2 . . 3 1
103 48 1 3 102 0 . 1 110 1 1 3 . . 1 1
104 63 1 4 96 305 0 1 121 1 1 1 . . 1 1
105 64 1 4 130 223 0 1 128 0 0.5 2 . . 0 0
106 61 1 4 120 282 0 1 135 1 4 3 . . 3 1
107 50 1 4 144 349 0 2 120 1 1 1 . . 1 1
108 59 1 4 124 . 0 0 117 1 1 2 . . 1 1
109 55 1 4 150 160 0 1 150 0 0 . . . 0 0
110 45 1 3 . 236 0 0 . . . . . . 0 0
111 65 1 4 . 312 0 2 . . . . . . 3 1
112 61 1 2 . 283 0 0 . . . . . . 0 0
113 49 1 3 . 142 0 0 . . . . . . 3 1
114 72 1 4 . 211 0 0 . . . . . . 1 1
115 50 1 4 . 218 0 0 . . . . . . 1 1
116 64 1 4 . 306 1 1 . . . . . . 3 1
117 55 1 4 116 186 1 1 102 0 0 . . . 2 1
118 63 1 4 110 252 0 1 140 1 2 2 . . 2 1
119 59 1 4 125 222 0 0 135 1 2.5 3 . . 3 1
120 56 1 4 . 0 0 2 . . . . . . 1 1
121 62 1 3 . 0 1 1 . . . . . . 2 1
122 74 1 4 150 258 1 1 130 1 4 3 . . 3 1
123 54 1 4 130 202 1 0 112 1 2 2 . . 1 1
124 57 1 4 110 197 0 2 100 0 0 . . . 0 0
125 62 1 3 . 204 0 1 . . . . . . 1 1
126 76 1 3 104 . 0 2 120 0 3.5 3 . . 4 1
127 54 0 4 138 274 0 0 105 1 1.5 2 . . 1 1
128 70 1 4 170 192 0 1 129 1 3 3 . . 2 1
129 61 0 2 140 298 1 0 120 1 0 . . . 0 0
130 48 1 4 . 272 0 1 . . . . . . 0 0
131 48 1 3 132 220 1 1 162 0 0 . . . 1 1
132 61 1 1 142 200 1 1 100 0 1.5 3 . . 3 1
133 66 1 4 112 261 0 0 140 0 1.5 1 . . 1 1
134 68 1 1 . 181 1 1 . . . . . . 0 0
135 55 1 4 172 260 0 0 73 0 2 . . . 3 1
136 62 1 3 120 220 0 2 86 0 0 . . . 0 0
137 71 1 3 . 221 0 0 . . . . . . 3 1
138 74 1 1 . 216 1 0 . . . . . . 3 1
139 53 1 3 155 175 1 1 160 0 . . . . 0 0
140 58 1 3 150 219 0 1 118 1 0 . . . 2 1
141 75 1 4 160 310 1 0 112 1 2 3 . . 0 0
142 56 1 3 . 208 1 1 . . . . . . 4 1
143 58 1 3 . 232 0 1 . . . . . . 2 1
144 64 1 4 134 273 0 0 102 1 4 3 . . 4 1
145 54 1 3 . 203 0 1 . . . . . . 0 0
146 54 1 2 . 182 0 1 . . . . . . 0 0
147 59 1 4 140 274 0 0 154 1 2 2 . . 0 0
148 55 1 4 . 204 1 1 . . . . . . 1 1
149 57 1 4 144 270 1 1 160 1 2 2 . . 3 1
150 61 1 4 . 292 0 1 . . . . . . 3 1
151 41 1 4 150 171 0 0 128 1 1.5 2 . . 0 0
152 71 1 4 130 221 0 1 115 1 0 . . . 3 1
153 38 1 4 110 289 0 0 105 1 1.5 3 . . 1 1
154 55 1 4 158 217 0 0 110 1 2.5 2 . . 1 1
155 56 1 4 128 223 0 1 119 1 2 3 . . 2 1
156 69 1 4 . . 1 0 . . . . . . 2 1
157 64 1 4 150 193 0 1 135 1 0.5 2 . . 2 1
158 72 1 4 160 . 1 2 130 0 1.5 . . . 2 1
159 69 1 4 . 210 1 1 . . . . . . 2 1
160 56 1 4 . 282 1 0 . . . . . . 1 1
161 62 1 4 . 170 0 1 120 1 3 . . . 4 1
162 67 1 4 . 369 0 0 . . . . . . 3 1
163 57 1 4 156 173 0 2 119 1 3 3 . . 3 1
164 69 1 4 . 289 1 1 . . . . . . 3 1
165 51 1 4 . . 1 2 . . . . . . 1 1
166 48 1 4 140 . 0 0 159 1 1.5 1 . . 3 1
167 69 1 4 122 216 1 2 84 1 0 . . . 2 1
168 69 1 3 . 271 0 2 . . . . . . 0 0
169 64 1 4 . 244 1 1 . . . . . . 2 1
170 57 1 2 180 285 1 1 120 0 0.8 . . . 1 1
171 53 1 4 124 243 0 0 122 1 2 2 . . 1 1
172 37 1 3 118 240 0 2 165 0 1 2 . . 0 0
173 67 1 4 140 219 0 1 122 1 2 2 . . 3 1
174 74 1 3 140 237 1 0 94 0 0 . . . 1 1
175 63 1 2 . 165 0 1 . . . . . . 0 0
176 58 1 4 100 213 0 1 110 0 0 . . . 0 0
177 61 1 4 190 287 1 2 150 1 2 3 . . 4 1
178 64 1 4 130 258 1 2 130 0 0 . . . 2 1
179 58 1 4 160 256 1 2 113 1 1 1 . . 3 1
180 60 1 4 130 186 1 2 140 1 0.5 2 . . 1 1
181 57 1 4 122 264 0 2 100 0 0 . . . 1 1
182 55 1 3 . . 0 1 . . . . . . 0 0
183 55 1 4 120 226 0 2 127 1 1.7 3 . . 1 1
184 56 1 4 130 203 1 0 98 0 1.5 2 . . 1 1
185 57 1 4 130 207 0 1 96 1 1 2 . . 0 0
186 61 1 3 . 284 0 0 . . . . . . 1 1
187 61 1 3 120 337 0 0 98 1 0 . . . 3 1
188 58 1 3 150 219 0 1 118 1 0 . . . 2 1
189 74 1 4 155 310 0 0 112 1 1.5 3 . . 2 1
190 68 1 3 134 254 1 0 151 1 0 . . . 0 0
191 51 0 4 114 258 1 2 96 0 1 1 . . 0 0
192 62 1 4 160 254 1 1 108 1 3 2 . . 4 1
193 53 1 4 144 300 1 1 128 1 1.5 2 . . 3 1
194 62 1 4 158 170 0 1 138 1 0 . . . 1 1
195 46 1 4 134 310 0 0 126 0 0 . . . 2 1
196 54 0 4 127 333 1 1 154 0 0 . . . 1 1
197 62 1 1 . 139 0 1 . . . . . . 0 0
198 55 1 4 122 223 1 1 100 0 0 . . . 2 1
199 58 1 4 . 385 1 2 . . . . . . 0 0
200 62 1 2 120 254 0 2 93 1 0 . . . 1 1
;
run;
proc sgscatter data=heart;
	plot presence*(age sex cp trestbps chol fbs restecg thalach exang oldpeak slope num) / loess=(smooth=0.25);
		run;
/*Correlations?*/
PROC SGSCATTER data=heart;
matrix presence age sex trestbps chol fbs restecg thalach exang oldpeak slope num;
run;
proc corr data=heart plots=matrix;
var presence age sex trestbps chol fbs restecg thalach exang oldpeak slope num;
run;
data heart2;
set heart;
if chol=0 then chol=.;
run;
proc sgscatter data=heart2;
	plot presence*(chol) / loess=(smooth=0.25);
run;
proc logistic data=heart2 ;
model presence=chol;
run;
/*proc univariate data=heart2 ;
var  age sex cp trestbps chol fbs restecg thalach exang oldpeak slope ca thal num presence;
run;*/



/*Main Model:*/
proc logistic data=heart2;
class sex cp fbs restecg exang slope;
model presence(event='1')= age sex cp trestbps chol fbs restecg thalach exang oldpeak  /selection=forward slentry=0.11 slstay=0.11 details lackfit;   
run;

/*Alternative model (age, cp) with variable with many missing values removed:*/
proc logistic data=heart2;
class sex cp fbs restecg exang;
model presence(event='1')= age sex cp chol fbs restecg  /
selection=stepwise;
run;
/*For some reason simply including slope as a class changes our results (age fbs)*/
    proc logistic data=heart2; /*heart 2 removes 0 chol values*/
class sex cp fbs restecg exang slope;
model presence(event='1')= age sex cp chol fbs restecg /selection=stewise slentry=0.2 slstay=0.2 /*details lackfit*/;
    run;






proc logistic data=heart2;
class sex cp fbs restecg exang;
model presence (event='1')= exang;
run;
proc logistic data=heart2;
class sex cp fbs restecg exang;
model presence (event='1')= exang cp;
run;
/*proc logistic data=heart descending;
class sex cp fbs restecg exang ;
model presence=exang trestbps;
run;*/
proc logistic data=heart descending;
class sex cp fbs restecg exang ;
model presence (event='1')=age cp;
run;
proc logistic data=heart descending;
class sex cp fbs restecg exang ;
model presence (event='1')=exang oldpeak ;
run;
proc logistic data=heart2;
class sex cp fbs restecg exang;
model presence (event='1')= sex cp fbs restecg exang;
run;



proc glm data=heart2;
class cp presence;
model presence=cp;
run;

/*age, oldpeak*/






















/*What predictors are associated with heart disease*/


/*Try individually?*/
proc logistic data=heart;
model presence=age /*sex cp trestbps chol fbs restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age */sex/* cp trestbps chol fbs restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
class cp;
model presence=/*age /*sex*/ cp /*trestbps chol fbs restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp */trestbps /*chol fbs restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps*/ chol /*fbs restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps chol*/ fbs /*restecg thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps chol fbs */restecg /*thalach exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps chol fbs restecg*/ thalach /*exang oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps chol fbs restecg thalach*/ exang /*oldpeak slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=/*age /*sex cp trestbps chol fbs restecg thalach exang */oldpeak /*slope ca thal num*/ ;
run;
proc logistic data=heart descending;
model presence=age /*sex cp trestbps chol fbs restecg thalach exang oldpeak*/ slope /*ca thal num*/ ;
run;

data heart2;
set heart;
if chol=0 then chol=.;
run;
proc sgscatter data=heart2;
	plot presence*(chol) / loess=(smooth=0.25);
run;
proc logistic data=heart2 ;
model presence=chol;
run;

/*Which were sig?*/
proc logistic data=heart2 descending;
class cp exang;
model presence=age cp trestbps chol/*take out 0s?*/ exang oldpeak 
/selection=backward;
run;

/*After taking out all 0s from cholestrol and removing more extreme outliers, chol still not significant*/



/*After testing each individually and THEN running a stepwise selection on the individually sig variables, we still can only include exang and oldpeak in our model*/
proc logistic data=heart descending;
model presence=exang trestbps;
run;



