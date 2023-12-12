![Method_overview_Fig_1](https://github.com/BIRDSgroup/Double-disease-interaction-analysis-/assets/60778368/451a72fd-bb1a-4b41-9149-95b88a4140d2)# Double-disease-interaction-analysis

This is the official repository of the paper "Systems analysis of multiple diabetes-helminth cohorts reveals
markers of disease-disease interaction" by Nilesh Subramanian, Philge Philip, Anuradha Rajamanickam, Nathella Pavan
Kumar, Subash Babu, and Manikandan Narayanan.


This repository contains two sections:

1. DDI pipeline
2. Application of our DDI pipeline on the Helminth-diabetes dataset 

## Section 1: DDI pipeline 
This section will provide information on how to run steps 2a, 2b, and 3 in the Figure below. step 1 will vary between the datasets used and a detailed methodology on the same in given in our paper.

![Upload<?xml version="1.0" encoding="utf-8"?>
<!-- Generator: Adobe Illustrator 28.1.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 762.28 584.46" style="enable-background:new 0 0 762.28 584.46;" xml:space="preserve">
<style type="text/css">
	.st0{fill:#ED1C24;}
	.st1{font-family:'MyriadPro-Regular';}
	.st2{font-size:18px;}
	.st3{fill:#FBB040;stroke:#000000;stroke-miterlimit:10;}
	.st4{font-size:14px;}
	.st5{fill:none;stroke:#000000;stroke-miterlimit:10;}
	.st6{fill:#00AEEF;stroke:#000000;stroke-miterlimit:10;}
	.st7{fill:#FFF200;stroke:#000000;stroke-miterlimit:10;}
	.st8{fill:#00A651;stroke:#000000;stroke-miterlimit:10;}
	.st9{stroke:#000000;stroke-width:2;stroke-miterlimit:10;}
	.st10{font-size:12.594px;}
	.st11{font-size:11px;}
	.st12{font-size:12.2023px;}
	.st13{fill:none;stroke:#000000;stroke-width:2;stroke-miterlimit:10;}
	.st14{fill:#FFFFFF;stroke:#ED1C24;stroke-miterlimit:10;}
	.st15{fill:#FFFFFF;stroke:#00AEEF;stroke-miterlimit:10;}
	.st16{fill:#FFFFFF;stroke:#00A651;stroke-miterlimit:10;}
	.st17{fill:#FFFFFF;stroke:#662D91;stroke-miterlimit:10;}
	.st18{fill:#FFFFFF;stroke:#F15A29;stroke-miterlimit:10;}
	.st19{font-size:11.2314px;}
	.st20{font-size:10.0144px;}
	.st21{font-size:9.5467px;}
	.st22{fill:none;}
	.st23{font-size:15px;}
	.st24{clip-path:url(#SVGID_00000055687407326841947020000006527383700200356793_);}
	.st25{stroke:#000000;stroke-miterlimit:10;}
	.st26{font-size:12px;}
</style>
<text transform="matrix(1 0 0 1 31.2012 61.8713)" class="st0 st1 st2">Our Disease-Disease Interaction Pipeline</text>
<g>
	<rect y="87.4" class="st3" width="87.57" height="29.39"/>
	<text transform="matrix(1 0 0 1 18.1539 106.873)" class="st1 st4">Control</text>
	<rect x="136.31" y="161.27" class="st5" width="103.95" height="43.97"/>
	<text transform="matrix(1 0 0 1 143.1162 264.0852)"><tspan x="0" y="0" class="st1 st4">2a. Main Effect</tspan><tspan x="17.23" y="16.8" class="st1 st4"> Analysis</tspan></text>
	<g>
		<rect x="43.67" y="164.75" class="st3" width="48.04" height="14.13"/>
		<rect x="43.67" y="178.57" class="st6" width="48.04" height="14.13"/>
		<rect x="43.67" y="192.39" class="st7" width="48.04" height="14.13"/>
		<rect x="43.67" y="206.2" class="st8" width="48.04" height="14.13"/>
	</g>
	<text transform="matrix(1 0 0 1 151.4979 178.5688)"><tspan x="0" y="0" class="st1 st4">1.  Dataset </tspan><tspan x="-0.27" y="16.8" class="st1 st4">preprocess</tspan></text>
	<line class="st5" x1="310.83" y1="117.21" x2="310.83" y2="122.56"/>
	<line class="st5" x1="310.89" y1="122.56" x2="39.18" y2="122.56"/>
	<line class="st5" x1="39.37" y1="117.04" x2="39.37" y2="122.39"/>
	<g>
		<g>
			<line class="st5" x1="175.04" y1="122.73" x2="175.04" y2="150.13"/>
			<g>
				<path d="M175.04,156.16c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C177.89,149.8,176.09,153.32,175.04,156.16z"/>
			</g>
		</g>
	</g>
	<rect x="130.76" y="414.76" class="st5" width="109.5" height="35.77"/>
	<text transform="matrix(1 0 0 1 133.3169 347.9872)"><tspan x="0" y="0" class="st1 st4">2b. Interaction Effect </tspan><tspan x="38.15" y="16.8" class="st1 st4">Analysis</tspan></text>
	<g>
		<g>
			<line class="st5" x1="175.04" y1="294.75" x2="175.04" y2="318.79"/>
			<g>
				<path d="M175.04,324.82c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C177.89,318.46,176.09,321.98,175.04,324.82z"/>
			</g>
		</g>
	</g>
	<text transform="matrix(1 0 0 1 34.2098 310.2768)" class="st1 st4">Main effect variables</text>
	<rect x="130.76" y="331.67" class="st5" width="127.19" height="38.73"/>
	<text transform="matrix(1 0 0 1 55.1543 397.016)" class="st1 st4">DDI markers</text>
	<g>
		<g>
			<line class="st5" x1="175.04" y1="210.34" x2="175.04" y2="237.74"/>
			<g>
				<path d="M175.04,243.78c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C177.89,237.41,176.09,240.94,175.04,243.78z"/>
			</g>
		</g>
	</g>
	<rect x="135.51" y="249.35" class="st5" width="104.75" height="38.56"/>
	<g>
		<g>
			<line class="st5" x1="174.02" y1="457.97" x2="174.02" y2="482.01"/>
			<g>
				<path d="M174.02,488.04c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C176.87,481.68,175.07,485.2,174.02,488.04z"/>
			</g>
		</g>
	</g>
	<text transform="matrix(1 0 0 1 137.6665 429.3357)"><tspan x="0" y="0" class="st1 st4">3. Downstream </tspan><tspan x="21.97" y="16.8" class="st1 st4">Analysis</tspan></text>
	<g>
		<g>
			<line class="st5" x1="175.04" y1="377.24" x2="175.04" y2="401.28"/>
			<g>
				<path d="M175.04,407.31c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C177.89,400.95,176.09,404.47,175.04,407.31z"/>
			</g>
		</g>
	</g>
	<text transform="matrix(1 0 0 1 87.566 502.3581)" class="st1 st4">Interpretation of DDI markers</text>
	<rect x="91.73" y="87.52" class="st6" width="87.57" height="29.39"/>
	<rect x="274.9" y="87.4" class="st8" width="87.57" height="29.39"/>
	<rect x="183.31" y="87.52" class="st7" width="87.57" height="29.39"/>
	<text transform="matrix(1 0 0 1 278.5561 106.8727)" class="st1 st4">Disease 1 &amp; 2</text>
	<text transform="matrix(1 0 0 1 184.3126 106.8729)" class="st1 st4">Disease 2 only</text>
	<text transform="matrix(1 0 0 1 94.0522 107.0269)" class="st1 st4">Disease 1 only</text>
	<text transform="matrix(1 0 0 1 13.6823 154.9155)" class="st1 st4">Concatenated Dataset </text>
</g>
<line class="st9" x1="373.28" y1="0" x2="373.28" y2="584.46"/>
<text transform="matrix(1 0 0 1 10.1605 23.3346)" class="st1 st2">A</text>
<g>
	<rect x="519.75" y="474.88" class="st3" width="39.97" height="11.76"/>
	<rect x="519.75" y="486.38" class="st6" width="39.97" height="11.76"/>
	<rect x="519.75" y="497.87" class="st7" width="39.97" height="11.76"/>
	<rect x="519.75" y="509.37" class="st8" width="39.97" height="11.76"/>
</g>
<text transform="matrix(1 0 0 1 511.2071 440.0808)" class="st0 st1 st10">Application of our DDI pipeline</text>
<g>
	<rect x="648.13" y="474.17" class="st3" width="39.97" height="11.76"/>
	<rect x="648.13" y="485.67" class="st6" width="39.97" height="11.76"/>
	<rect x="648.13" y="497.16" class="st7" width="39.97" height="11.76"/>
	<rect x="648.13" y="508.66" class="st8" width="39.97" height="11.76"/>
</g>
<text transform="matrix(1 0 0 1 463.7558 463.2669)" class="st0 st1 st11">Before Treatment samples</text>
<text transform="matrix(1 0 0 1 614.7859 463.2666)" class="st0 st1 st11">After Treatment samples</text>
<g>
	<g>
		<line class="st5" x1="539.73" y1="523.33" x2="539.73" y2="530.97"/>
		<g>
			<path d="M539.73,537c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C542.58,530.64,540.79,534.16,539.73,537z"/>
		</g>
	</g>
</g>
<rect x="503.67" y="538.23" class="st5" width="70.31" height="15.91"/>
<text transform="matrix(1 0 0 1 508.1691 548.4423)" class="st1 st12">Our Pipeline</text>
<g>
	<g>
		<line class="st5" x1="668.12" y1="523.54" x2="668.12" y2="531.19"/>
		<g>
			<path d="M668.12,537.22c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C670.97,530.86,669.17,534.38,668.12,537.22z"/>
		</g>
	</g>
</g>
<g>
	<g>
		<line class="st5" x1="538.59" y1="554.15" x2="538.59" y2="561.79"/>
		<g>
			<path d="M538.59,567.83c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C541.44,561.46,539.64,564.99,538.59,567.83z"/>
		</g>
	</g>
</g>
<g>
	<g>
		<line class="st5" x1="668.12" y1="554.14" x2="668.12" y2="561.78"/>
		<g>
			<path d="M668.12,567.82c-1.05-2.84-2.85-6.36-4.76-8.55l4.76,1.72l4.75-1.72C670.97,561.45,669.17,564.98,668.12,567.82z"/>
		</g>
	</g>
</g>
<text transform="matrix(1 0 0 1 451.4144 579.3268)" class="st1 st11">DDI markers and Interpretations</text>
<text transform="matrix(1 0 0 1 609.3891 579.3268)" class="st1 st11">DDI markers and interpretations</text>
<g>
	<g>
		<g>
			<rect x="458.27" y="43.33" class="st13" width="280.13" height="173.4"/>
			<g>
				<g>
					<ellipse class="st14" cx="487.05" cy="70.09" rx="2.08" ry="2.33"/>
					<rect x="484.22" y="72.42" class="st14" width="5.65" height="7.83"/>
					<rect x="484.22" y="80.25" class="st14" width="2.82" height="5.5"/>
					<rect x="487.05" y="80.25" class="st14" width="2.82" height="5.5"/>
					<rect x="482.59" y="72.42" class="st14" width="1.63" height="6.33"/>
					<rect x="489.87" y="72.42" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="507.86" cy="69.67" rx="2.08" ry="2.33"/>
					<rect x="505.03" y="72" class="st15" width="5.65" height="7.83"/>
					<rect x="505.03" y="79.84" class="st15" width="2.82" height="5.5"/>
					<rect x="507.86" y="79.84" class="st15" width="2.82" height="5.5"/>
					<rect x="503.4" y="72" class="st15" width="1.63" height="6.33"/>
					<rect x="510.68" y="72" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="497.45" cy="69.67" rx="2.08" ry="2.33"/>
					<rect x="494.63" y="72" class="st16" width="5.65" height="7.83"/>
					<rect x="494.63" y="79.84" class="st16" width="2.82" height="5.5"/>
					<rect x="497.45" y="79.84" class="st16" width="2.82" height="5.5"/>
					<rect x="492.99" y="72" class="st16" width="1.63" height="6.33"/>
					<rect x="500.28" y="72" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="487.05" cy="91.13" rx="2.08" ry="2.33"/>
					<rect x="484.22" y="93.46" class="st17" width="5.65" height="7.83"/>
					<rect x="484.22" y="101.3" class="st17" width="2.82" height="5.5"/>
					<rect x="487.05" y="101.3" class="st17" width="2.82" height="5.5"/>
					<rect x="482.59" y="93.46" class="st17" width="1.63" height="6.33"/>
					<rect x="489.87" y="93.46" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="507.86" cy="90.71" rx="2.08" ry="2.33"/>
					<rect x="505.03" y="93.05" class="st18" width="5.65" height="7.83"/>
					<rect x="505.03" y="100.88" class="st18" width="2.82" height="5.5"/>
					<rect x="507.86" y="100.88" class="st18" width="2.82" height="5.5"/>
					<rect x="503.4" y="93.05" class="st18" width="1.63" height="6.33"/>
					<rect x="510.68" y="93.05" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="497.45" cy="90.71" rx="2.08" ry="2.33"/>
					<rect x="494.63" y="93.05" class="st15" width="5.65" height="7.83"/>
					<rect x="494.63" y="100.88" class="st15" width="2.82" height="5.5"/>
					<rect x="497.45" y="100.88" class="st15" width="2.82" height="5.5"/>
					<rect x="492.99" y="93.05" class="st15" width="1.63" height="6.33"/>
					<rect x="500.28" y="93.05" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="497.86" cy="87.82" rx="23.78" ry="26.67"/>
			</g>
			<line class="st13" x1="554.84" y1="43.33" x2="554.84" y2="216.73"/>
			<line class="st13" x1="458.27" y1="130.03" x2="738.4" y2="130.03"/>
			<g>
				<g>
					<ellipse class="st14" cx="577.47" cy="68.73" rx="2.08" ry="2.33"/>
					<rect x="574.65" y="71.07" class="st14" width="5.65" height="7.83"/>
					<rect x="574.65" y="78.9" class="st14" width="2.82" height="5.5"/>
					<rect x="577.47" y="78.9" class="st14" width="2.82" height="5.5"/>
					<rect x="573.01" y="71.07" class="st14" width="1.63" height="6.33"/>
					<rect x="580.29" y="71.07" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="598.28" cy="68.31" rx="2.08" ry="2.33"/>
					<rect x="595.45" y="70.65" class="st15" width="5.65" height="7.83"/>
					<rect x="595.45" y="78.48" class="st15" width="2.82" height="5.5"/>
					<rect x="598.28" y="78.48" class="st15" width="2.82" height="5.5"/>
					<rect x="593.82" y="70.65" class="st15" width="1.63" height="6.33"/>
					<rect x="601.1" y="70.65" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="587.87" cy="68.31" rx="2.08" ry="2.33"/>
					<rect x="585.05" y="70.65" class="st16" width="5.65" height="7.83"/>
					<rect x="585.05" y="78.48" class="st16" width="2.82" height="5.5"/>
					<rect x="587.87" y="78.48" class="st16" width="2.82" height="5.5"/>
					<rect x="583.42" y="70.65" class="st16" width="1.63" height="6.33"/>
					<rect x="590.7" y="70.65" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="577.47" cy="89.77" rx="2.08" ry="2.33"/>
					<rect x="574.65" y="92.11" class="st17" width="5.65" height="7.83"/>
					<rect x="574.65" y="99.94" class="st17" width="2.82" height="5.5"/>
					<rect x="577.47" y="99.94" class="st17" width="2.82" height="5.5"/>
					<rect x="573.01" y="92.11" class="st17" width="1.63" height="6.33"/>
					<rect x="580.29" y="92.11" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="598.28" cy="89.36" rx="2.08" ry="2.33"/>
					<rect x="595.45" y="91.69" class="st18" width="5.65" height="7.83"/>
					<rect x="595.45" y="99.53" class="st18" width="2.82" height="5.5"/>
					<rect x="598.28" y="99.53" class="st18" width="2.82" height="5.5"/>
					<rect x="593.82" y="91.69" class="st18" width="1.63" height="6.33"/>
					<rect x="601.1" y="91.69" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="587.87" cy="89.36" rx="2.08" ry="2.33"/>
					<rect x="585.05" y="91.69" class="st15" width="5.65" height="7.83"/>
					<rect x="585.05" y="99.53" class="st15" width="2.82" height="5.5"/>
					<rect x="587.87" y="99.53" class="st15" width="2.82" height="5.5"/>
					<rect x="583.42" y="91.69" class="st15" width="1.63" height="6.33"/>
					<rect x="590.7" y="91.69" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="588.28" cy="86.46" rx="23.78" ry="26.67"/>
			</g>
			<g>
				<g>
					<ellipse class="st14" cx="664.62" cy="70.09" rx="2.08" ry="2.33"/>
					<rect x="661.79" y="72.42" class="st14" width="5.65" height="7.83"/>
					<rect x="661.79" y="80.25" class="st14" width="2.82" height="5.5"/>
					<rect x="664.62" y="80.25" class="st14" width="2.82" height="5.5"/>
					<rect x="660.16" y="72.42" class="st14" width="1.63" height="6.33"/>
					<rect x="667.44" y="72.42" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="685.42" cy="69.67" rx="2.08" ry="2.33"/>
					<rect x="682.6" y="72" class="st15" width="5.65" height="7.83"/>
					<rect x="682.6" y="79.84" class="st15" width="2.82" height="5.5"/>
					<rect x="685.42" y="79.84" class="st15" width="2.82" height="5.5"/>
					<rect x="680.97" y="72" class="st15" width="1.63" height="6.33"/>
					<rect x="688.25" y="72" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="675.02" cy="69.67" rx="2.08" ry="2.33"/>
					<rect x="672.2" y="72" class="st16" width="5.65" height="7.83"/>
					<rect x="672.2" y="79.84" class="st16" width="2.82" height="5.5"/>
					<rect x="675.02" y="79.84" class="st16" width="2.82" height="5.5"/>
					<rect x="670.56" y="72" class="st16" width="1.63" height="6.33"/>
					<rect x="677.84" y="72" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="664.62" cy="91.13" rx="2.08" ry="2.33"/>
					<rect x="661.79" y="93.46" class="st17" width="5.65" height="7.83"/>
					<rect x="661.79" y="101.3" class="st17" width="2.82" height="5.5"/>
					<rect x="664.62" y="101.3" class="st17" width="2.82" height="5.5"/>
					<rect x="660.16" y="93.46" class="st17" width="1.63" height="6.33"/>
					<rect x="667.44" y="93.46" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="685.42" cy="90.71" rx="2.08" ry="2.33"/>
					<rect x="682.6" y="93.05" class="st18" width="5.65" height="7.83"/>
					<rect x="682.6" y="100.88" class="st18" width="2.82" height="5.5"/>
					<rect x="685.42" y="100.88" class="st18" width="2.82" height="5.5"/>
					<rect x="680.97" y="93.05" class="st18" width="1.63" height="6.33"/>
					<rect x="688.25" y="93.05" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="675.02" cy="90.71" rx="2.08" ry="2.33"/>
					<rect x="672.2" y="93.05" class="st15" width="5.65" height="7.83"/>
					<rect x="672.2" y="100.88" class="st15" width="2.82" height="5.5"/>
					<rect x="675.02" y="100.88" class="st15" width="2.82" height="5.5"/>
					<rect x="670.56" y="93.05" class="st15" width="1.63" height="6.33"/>
					<rect x="677.84" y="93.05" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="675.43" cy="87.82" rx="23.78" ry="26.67"/>
			</g>
			<g>
				<g>
					<ellipse class="st14" cx="485.23" cy="155.87" rx="2.08" ry="2.33"/>
					<rect x="482.4" y="158.2" class="st14" width="5.65" height="7.83"/>
					<rect x="482.4" y="166.03" class="st14" width="2.82" height="5.5"/>
					<rect x="485.23" y="166.03" class="st14" width="2.82" height="5.5"/>
					<rect x="480.77" y="158.2" class="st14" width="1.63" height="6.33"/>
					<rect x="488.05" y="158.2" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="506.03" cy="155.45" rx="2.08" ry="2.33"/>
					<rect x="503.21" y="157.78" class="st15" width="5.65" height="7.83"/>
					<rect x="503.21" y="165.62" class="st15" width="2.82" height="5.5"/>
					<rect x="506.03" y="165.62" class="st15" width="2.82" height="5.5"/>
					<rect x="501.57" y="157.78" class="st15" width="1.63" height="6.33"/>
					<rect x="508.86" y="157.78" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="495.63" cy="155.45" rx="2.08" ry="2.33"/>
					<rect x="492.81" y="157.78" class="st16" width="5.65" height="7.83"/>
					<rect x="492.81" y="165.62" class="st16" width="2.82" height="5.5"/>
					<rect x="495.63" y="165.62" class="st16" width="2.82" height="5.5"/>
					<rect x="491.17" y="157.78" class="st16" width="1.63" height="6.33"/>
					<rect x="498.45" y="157.78" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="485.23" cy="176.91" rx="2.08" ry="2.33"/>
					<rect x="482.4" y="179.24" class="st17" width="5.65" height="7.83"/>
					<rect x="482.4" y="187.08" class="st17" width="2.82" height="5.5"/>
					<rect x="485.23" y="187.08" class="st17" width="2.82" height="5.5"/>
					<rect x="480.77" y="179.24" class="st17" width="1.63" height="6.33"/>
					<rect x="488.05" y="179.24" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="506.03" cy="176.49" rx="2.08" ry="2.33"/>
					<rect x="503.21" y="178.83" class="st18" width="5.65" height="7.83"/>
					<rect x="503.21" y="186.66" class="st18" width="2.82" height="5.5"/>
					<rect x="506.03" y="186.66" class="st18" width="2.82" height="5.5"/>
					<rect x="501.57" y="178.83" class="st18" width="1.63" height="6.33"/>
					<rect x="508.86" y="178.83" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="495.63" cy="176.49" rx="2.08" ry="2.33"/>
					<rect x="492.81" y="178.83" class="st15" width="5.65" height="7.83"/>
					<rect x="492.81" y="186.66" class="st15" width="2.82" height="5.5"/>
					<rect x="495.63" y="186.66" class="st15" width="2.82" height="5.5"/>
					<rect x="491.17" y="178.83" class="st15" width="1.63" height="6.33"/>
					<rect x="498.45" y="178.83" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="496.04" cy="173.6" rx="23.78" ry="26.67"/>
			</g>
			<g>
				<g>
					<ellipse class="st14" cx="578.88" cy="154.51" rx="2.08" ry="2.33"/>
					<rect x="576.06" y="156.84" class="st14" width="5.65" height="7.83"/>
					<rect x="576.06" y="164.68" class="st14" width="2.82" height="5.5"/>
					<rect x="578.88" y="164.68" class="st14" width="2.82" height="5.5"/>
					<rect x="574.42" y="156.84" class="st14" width="1.63" height="6.33"/>
					<rect x="581.71" y="156.84" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="599.69" cy="154.09" rx="2.08" ry="2.33"/>
					<rect x="596.87" y="156.43" class="st15" width="5.65" height="7.83"/>
					<rect x="596.87" y="164.26" class="st15" width="2.82" height="5.5"/>
					<rect x="599.69" y="164.26" class="st15" width="2.82" height="5.5"/>
					<rect x="595.23" y="156.43" class="st15" width="1.63" height="6.33"/>
					<rect x="602.51" y="156.43" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="589.29" cy="154.09" rx="2.08" ry="2.33"/>
					<rect x="586.46" y="156.43" class="st16" width="5.65" height="7.83"/>
					<rect x="586.46" y="164.26" class="st16" width="2.82" height="5.5"/>
					<rect x="589.29" y="164.26" class="st16" width="2.82" height="5.5"/>
					<rect x="584.83" y="156.43" class="st16" width="1.63" height="6.33"/>
					<rect x="592.11" y="156.43" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="578.88" cy="175.55" rx="2.08" ry="2.33"/>
					<rect x="576.06" y="177.89" class="st17" width="5.65" height="7.83"/>
					<rect x="576.06" y="185.72" class="st17" width="2.82" height="5.5"/>
					<rect x="578.88" y="185.72" class="st17" width="2.82" height="5.5"/>
					<rect x="574.42" y="177.89" class="st17" width="1.63" height="6.33"/>
					<rect x="581.71" y="177.89" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="599.69" cy="175.14" rx="2.08" ry="2.33"/>
					<rect x="596.87" y="177.47" class="st18" width="5.65" height="7.83"/>
					<rect x="596.87" y="185.3" class="st18" width="2.82" height="5.5"/>
					<rect x="599.69" y="185.3" class="st18" width="2.82" height="5.5"/>
					<rect x="595.23" y="177.47" class="st18" width="1.63" height="6.33"/>
					<rect x="602.51" y="177.47" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="589.29" cy="175.14" rx="2.08" ry="2.33"/>
					<rect x="586.46" y="177.47" class="st15" width="5.65" height="7.83"/>
					<rect x="586.46" y="185.3" class="st15" width="2.82" height="5.5"/>
					<rect x="589.29" y="185.3" class="st15" width="2.82" height="5.5"/>
					<rect x="584.83" y="177.47" class="st15" width="1.63" height="6.33"/>
					<rect x="592.11" y="177.47" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="589.7" cy="172.24" rx="23.78" ry="26.67"/>
			</g>
			<g>
				<g>
					<ellipse class="st14" cx="668.85" cy="155.87" rx="2.08" ry="2.33"/>
					<rect x="666.03" y="158.2" class="st14" width="5.65" height="7.83"/>
					<rect x="666.03" y="166.03" class="st14" width="2.82" height="5.5"/>
					<rect x="668.85" y="166.03" class="st14" width="2.82" height="5.5"/>
					<rect x="664.39" y="158.2" class="st14" width="1.63" height="6.33"/>
					<rect x="671.68" y="158.2" class="st14" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="689.66" cy="155.45" rx="2.08" ry="2.33"/>
					<rect x="686.84" y="157.78" class="st15" width="5.65" height="7.83"/>
					<rect x="686.84" y="165.62" class="st15" width="2.82" height="5.5"/>
					<rect x="689.66" y="165.62" class="st15" width="2.82" height="5.5"/>
					<rect x="685.2" y="157.78" class="st15" width="1.63" height="6.33"/>
					<rect x="692.48" y="157.78" class="st15" width="1.63" height="6.33"/>
					<ellipse class="st16" cx="679.26" cy="155.45" rx="2.08" ry="2.33"/>
					<rect x="676.43" y="157.78" class="st16" width="5.65" height="7.83"/>
					<rect x="676.43" y="165.62" class="st16" width="2.82" height="5.5"/>
					<rect x="679.26" y="165.62" class="st16" width="2.82" height="5.5"/>
					<rect x="674.8" y="157.78" class="st16" width="1.63" height="6.33"/>
					<rect x="682.08" y="157.78" class="st16" width="1.63" height="6.33"/>
					<ellipse class="st17" cx="668.85" cy="176.91" rx="2.08" ry="2.33"/>
					<rect x="666.03" y="179.24" class="st17" width="5.65" height="7.83"/>
					<rect x="666.03" y="187.08" class="st17" width="2.82" height="5.5"/>
					<rect x="668.85" y="187.08" class="st17" width="2.82" height="5.5"/>
					<rect x="664.39" y="179.24" class="st17" width="1.63" height="6.33"/>
					<rect x="671.68" y="179.24" class="st17" width="1.63" height="6.33"/>
					<ellipse class="st18" cx="689.66" cy="176.49" rx="2.08" ry="2.33"/>
					<rect x="686.84" y="178.83" class="st18" width="5.65" height="7.83"/>
					<rect x="686.84" y="186.66" class="st18" width="2.82" height="5.5"/>
					<rect x="689.66" y="186.66" class="st18" width="2.82" height="5.5"/>
					<rect x="685.2" y="178.83" class="st18" width="1.63" height="6.33"/>
					<rect x="692.48" y="178.83" class="st18" width="1.63" height="6.33"/>
					<ellipse class="st15" cx="679.26" cy="176.49" rx="2.08" ry="2.33"/>
					<rect x="676.43" y="178.83" class="st15" width="5.65" height="7.83"/>
					<rect x="676.43" y="186.66" class="st15" width="2.82" height="5.5"/>
					<rect x="679.26" y="186.66" class="st15" width="2.82" height="5.5"/>
					<rect x="674.8" y="178.83" class="st15" width="1.63" height="6.33"/>
					<rect x="682.08" y="178.83" class="st15" width="1.63" height="6.33"/>
				</g>
				<ellipse class="st5" cx="679.67" cy="173.6" rx="23.78" ry="26.67"/>
			</g>
			<text transform="matrix(0.8916 0 0 1 471.857 36.4829)" class="st1 st19">No Helminth</text>
			<text transform="matrix(0 -1.1215 1 0 439.3975 114.4146)"><tspan x="0" y="0" class="st1 st20">No Diabetes</tspan><tspan x="0" y="12.02" class="st1 st20">     (DM-)</tspan></text>
			<text transform="matrix(0.8916 0 0 1 463.1089 57.7798)" class="st1 st21">DM- Control (60 samples)</text>
			<text transform="matrix(0.8916 0 0 1 554.8404 36.4829)" class="st1 st19">With Helminth</text>
			<text transform="matrix(0 -1.1215 1 0 439.3975 210.0728)"><tspan x="0" y="0" class="st1 st20">With Diabetes</tspan><tspan x="0" y="12.02" class="st1 st20">       (DM+)</tspan></text>
			<text transform="matrix(0.8916 0 0 1 461.0493 142.2915)" class="st1 st21">DM+ Control (58 samples)</text>
			<text transform="matrix(0.8916 0 0 1 559.6285 57.6636)" class="st1 st21">DM- PreT (60 samples)</text>
			<text transform="matrix(0.8916 0 0 1 560.2759 142.2915)" class="st1 st21">DM+ PreT (60 samples)</text>
			<text transform="matrix(0.8916 0 0 1 649.4185 57.7798)" class="st1 st21">DM- PostT (44 samples)</text>
			<text transform="matrix(0.8916 0 0 1 650.0655 142.2915)" class="st1 st21">DM+ PostT (60 samples)</text>
		</g>
		<rect x="419.69" y="15.72" class="st22" width="342.59" height="228.38"/>
	</g>
</g>
<text transform="matrix(1 0 0 1 510.3374 13.5376)" class="st0 st1 st23">Multi-cohort data</text>
<g>
	<defs>
		<rect id="SVGID_1_" x="457.04" y="235.44" width="223.89" height="197.5"/>
	</defs>
	<clipPath id="SVGID_00000170260161309224213620000015338188915721210295_">
		<use xlink:href="#SVGID_1_"  style="overflow:visible;"/>
	</clipPath>
	<g style="clip-path:url(#SVGID_00000170260161309224213620000015338188915721210295_);">
		<path d="M394.71,163.51"/>
	</g>
</g>
<text transform="matrix(1 0 0 1 485.6458 261.3672)" class="st1 st11">Blood Measurements</text>
<text transform="matrix(1 0 0 1 592.0276 261.5712)" class="st1 st11">Demographic Measurements</text>
<line class="st25" x1="616.92" y1="269.97" x2="616.92" y2="305.43"/>
<line class="st25" x1="616.79" y1="282.7" x2="642.26" y2="282.7"/>
<text transform="matrix(1 0 0 1 646.7591 284.3359)" class="st1 st11">Age</text>
<line class="st25" x1="616.79" y1="305.43" x2="642.26" y2="305.43"/>
<text transform="matrix(1 0 0 1 645.7025 307.0634)" class="st1 st11">Gender</text>
<line class="st25" x1="511.82" y1="269.16" x2="511.82" y2="304.62"/>
<line class="st25" x1="470.04" y1="304.62" x2="580.48" y2="304.62"/>
<text transform="matrix(1 0 0 1 439.1252 320.9774)" class="st1 st11">Cytokines</text>
<text transform="matrix(1 0 0 1 495.9977 321.8564)" class="st1 st11">Cell counts</text>
<text transform="matrix(1 0 0 1 555.5833 321.8564)" class="st1 st11">Biochemical parameters</text>
<line class="st25" x1="470.04" y1="304.62" x2="470.04" y2="311.44"/>
<line class="st25" x1="517.41" y1="304.62" x2="517.41" y2="311.44"/>
<line class="st25" x1="580.48" y1="304.36" x2="580.48" y2="311.17"/>
<line class="st5" x1="470.04" y1="324.72" x2="470.04" y2="393.71"/>
<line class="st25" x1="470.53" y1="343.53" x2="496" y2="343.53"/>
<text transform="matrix(1 0 0 1 498.6849 345.5566)" class="st1 st11">T helper cytokines</text>
<line class="st25" x1="520.94" y1="349.96" x2="520.94" y2="361.74"/>
<line class="st25" x1="520.94" y1="361.74" x2="532.71" y2="361.74"/>
<text transform="matrix(1 0 0 1 538.5853 360.9612)"><tspan x="0" y="0" class="st1 st11">Th-1, Th-2, </tspan><tspan x="0" y="13.2" class="st1 st11">Th-17 </tspan></text>
<line class="st25" x1="470.53" y1="393.71" x2="496" y2="393.71"/>
<text transform="matrix(1 0 0 1 498.6741 395.1454)" class="st1 st11">Other  cytokines</text>
<line class="st5" x1="604.32" y1="324.78" x2="604.32" y2="409.33"/>
<line class="st25" x1="604.48" y1="337.1" x2="629.95" y2="337.1"/>
<text transform="matrix(1 0 0 1 632.6341 339.1269)" class="st1 st11">Excretory parameters</text>
<line class="st25" x1="604.48" y1="355.85" x2="629.95" y2="355.85"/>
<text transform="matrix(1 0 0 1 632.6341 357.875)" class="st1 st11">Liver parameters</text>
<line class="st25" x1="604.48" y1="373.48" x2="629.95" y2="373.48"/>
<text transform="matrix(1 0 0 1 632.6341 375.5019)" class="st1 st11">RBC parameters</text>
<line class="st25" x1="604.48" y1="390.69" x2="629.95" y2="390.69"/>
<text transform="matrix(1 0 0 1 632.6341 392.7148)" class="st1 st11">Antibody</text>
<line class="st25" x1="604.32" y1="409.5" x2="629.78" y2="409.5"/>
<text transform="matrix(1 0 0 1 632.47 411.8779)" class="st1 st11">Glycemic parameters</text>
<text transform="matrix(1 0 0 1 545.3792 241.7617)" class="st0 st1 st26">50 Variables</text>
<text transform="matrix(1 0 0 1 389.2484 23.3343)" class="st1 st2">B</text>
<rect x="632.96" y="538.23" class="st5" width="70.31" height="15.91"/>
<text transform="matrix(1 0 0 1 637.5992 548.4427)" class="st1 st12">Our Pipeline</text>
<text transform="matrix(1 0 0 1 381.1378 244.0959)" class="st1 st2">C</text>
<text transform="matrix(0.9295 0 0 1 381.7857 442.574)" class="st1 st2">D</text>
</svg>
ing Method_overview_Fig_1.svg…]()



This repository contains codes, scripts, and data to replicate the results in our paper (cite).
We also provide a generalized function called **"MI_func"** (check the "functions" folder) which can be applied to any double disease conditions (provided necessary cohorts are available).

This file has been separated into four sections to facilitate navigating the repository.

1. **Replicating the results**
2. **Dissecting the scripts**
3. **Figures, Supplementary Figures, and Supplementary Tables**
4. **Functions**
5. **Data**

## Section - 1 - Replicating the results 

There are three main scripts in this section. Running these scripts with slight modifications in the working directory will replicate the results from our work.<br>
**Details on the output generated from each of these scripts are given in the README files in each of their folders.**
1. **MI_script.R** 
2. **Validation_script.R**
3. **Interpretation_script.R**

## Section - 2 - Figures, Supplementary Figures, and Supplementary Tables


