Shader "PlanetEarthShader/Earth" {
	Properties {
		_MainTex 		("Texture (RGB)", 2D) = "white" {}
		_SpecColor 		("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess 		("Shininess", Range (0.03, 1)) = 0.078125
		_Mask			("Gloss Mask (RGB)", 2D) = "white" {}
		_BumpMap 		("BumpMap", 2D) = "bump" {}
		_Emission		("Night Lights (RGB)", 2D) = "black" {}
		_LightAmount	("Night Lights Intensity", Range(0, 10)) = 1
		_AtmosFalloff 	("Atmosphere Falloff", Range(0.5,8.0)) = 3.0
		_AtmosNear 		("Inner Atmosphere", Color) = (0,0,1,1)
		_AtmosFar 		("Far Atmosphere", Color) = (0,0,1,1)
		_Clouds 		("Clouds (RGB)", 2D) = "black" {}
		_CloudHeight	("Cloud Height", Range(0,.1)) = 0.05
		_CloudSpeed		("Cloud Speed", Range(0,1)) = .1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma exclude_renderers xbox360 ps3 flash
		#pragma target 3.0
		#pragma surface surf BlinnPhong

		sampler2D _MainTex, _BumpMap, _Emission, _Clouds, _Mask;
		fixed _LightAmount, _AtmosFalloff, _CloudSpeed, _CloudHeight, _Shininess;
		fixed3 _AtmosNear, _AtmosFar;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Emission;
			float2 uv_Clouds;
			float3 viewDir;
			float2 uv_Mask;
		};

		void surf (Input IN, inout SurfaceOutput o) {															
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			
			//Atmosphere
			fixed fresnel = 1.0 - saturate(dot( normalize(IN.viewDir), half3(0,0,1) ) );
			fixed fresnelPowered = pow(fresnel, _AtmosFalloff);
			
			fixed3 atmosphere = lerp(_AtmosNear, _AtmosFar, fresnelPowered);
			fixed3 cleanSky = c.rgb + atmosphere * fresnelPowered;
			
			//Clouds
			half2 cloudUV = IN.uv_Clouds;
			cloudUV.x += _Time * _CloudSpeed;//UV Pan in x axis
			cloudUV += ParallaxOffset(1,_CloudHeight,IN.viewDir);
			fixed4 clouds = tex2D(_Clouds, cloudUV); 

			o.Albedo = cleanSky + clouds;//lerp(cleanSky, clouds.rgb, clouds.rgb);
			o.Normal = lerp(UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)), half3(0,0,1), half3(clouds));
			o.Emission = lerp(tex2D(_Emission, IN.uv_Emission) * _LightAmount, 0, clouds);
			o.Specular = _Shininess;
			o.Gloss =  tex2D(_Mask, IN.uv_Mask) * (1 - clouds) * _SpecColor;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
