﻿Shader "CookBook/SpriteSheetAnimation" 
{
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TexWidth ("Sheet Width", float) = 0.0
		_CellAmount ("Cell Amount", float) = 0.0
		_Speed ("Speed", Range(0.01, 32)) = 12
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Get Value from "Properies" block
		sampler2D _MainTex;
		float _TexWidth;
		float _CellAmount;
		float _Speed;
		
		struct Input {
			float2 uv_MainTex;
		};

		
		void surf(Input IN, inout SurfaceOutput o)
		{
			float2 spriteUV = IN.uv_MainTex;
			
			float cellPixelWidth = _TexWidth / _CellAmount;
			float cellUVPercentage = cellPixelWidth / _TexWidth;
			
			float timeVal = fmod(_Time.y * _Speed, _CellAmount);
			timeVal = ceil(timeVal);
			
			float xValue = spriteUV.x;
			xValue += cellUVPercentage * timeVal * _CellAmount;
			xValue *= cellUVPercentage;
			
			spriteUV = float2(xValue, spriteUV.y);
			
			// 텍스처와 색조를 적용한다.
			half4 c = tex2D(_MainTex, spriteUV);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}