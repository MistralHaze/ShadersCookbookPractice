﻿Shader "Reaprendiendo lo basico/ScrollingShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D)="white" {}
        _ScrollingSpeedX("XMovemement", Range(0,10))=0
        _ScrollingSpeedY("XMovemement", Range(0,10))=0

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		

		struct Input {
			float2 uv_MainTex;
		};
        float _Slider;
		fixed4 _Color;
        fixed _ScrollingSpeedX;
        fixed _ScrollingSpeedY;
        sampler2D _MainTex;


		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) 
        {
            // Create a separate variable to store our UVs
            // before we pass them to the tex2D() function
            fixed2 scrolledUV=IN.uv_MainTex;

            // Create variables that store the individual x and y
            // components for the UV's scaled by time
            fixed xScrollValue= _ScrollingSpeedX*_Time;
            fixed yScrollValue= _ScrollingSpeedY*_Time;

            //Apply the changes
            scrolledUV+= fixed2(xScrollValue,yScrollValue);

			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, scrolledUV) ;
			o.Albedo = c.rgb* _Color;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
