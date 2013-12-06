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
		
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 12
//   opengl - ALU: 23 to 83
//   d3d9 - ALU: 24 to 86
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_Emission_ST]
Vector 26 [_Clouds_ST]
Vector 27 [_Mask_ST]
"3.0-!!ARBvp1.0
# 47 ALU
PARAM c[28] = { { 1 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.y, R1, c[19];
DP4 R3.x, R1, c[18];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[5].xyz, R2, R3;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[22].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 47 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_Emission_ST]
Vector 25 [_Clouds_ST]
Vector 26 [_Mask_ST]
"vs_3_0
; 50 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c27, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c20
add o6.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c27.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c21.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_7 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_20;
  lowp vec4 c_22;
  highp float nh_23;
  lowp float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_21))));
  nh_23 = tmpvar_25;
  mediump float arg1_26;
  arg1_26 = (tmpvar_3 * 128.0);
  highp float tmpvar_27;
  tmpvar_27 = (pow (nh_23, arg1_26) * tmpvar_19);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_24) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_27)) * 2.0);
  c_22.xyz = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_6.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_27));
  c_22.w = tmpvar_29;
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_7 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_21;
  lowp vec4 c_23;
  highp float nh_24;
  lowp float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_19, xlv_TEXCOORD4));
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, normalize((xlv_TEXCOORD4 + viewDir_22))));
  nh_24 = tmpvar_26;
  mediump float arg1_27;
  arg1_27 = (tmpvar_3 * 128.0);
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_24, arg1_27) * tmpvar_20);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_25) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_28)) * 2.0);
  c_23.xyz = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (tmpvar_6.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_28));
  c_23.w = tmpvar_30;
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 441
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 445
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 449
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 457
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 465
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 469
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 473
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 477
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
Vector 19 [_Emission_ST]
Vector 20 [_Clouds_ST]
Vector 21 [_Mask_ST]
"3.0-!!ARBvp1.0
# 23 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
Vector 17 [_Emission_ST]
Vector 18 [_Clouds_ST]
Vector 19 [_Mask_ST]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c20.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o4.y, r0, r1
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o2.zw, v3.xyxy, c18.xyxy, c18
mad o2.xy, v3, c17, c17.zwzw
mad o3.xy, v3, c19, c19.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_3;
  lowp float fresnel_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_4 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = pow (fresnel_4, _AtmosFalloff);
  cloudUV_3 = tmpvar_2;
  highp float tmpvar_8;
  tmpvar_8 = (cloudUV_3.x + (_Time * _CloudSpeed).x);
  cloudUV_3.x = tmpvar_8;
  mediump float height_9;
  height_9 = _CloudHeight;
  mediump vec3 viewDir_10;
  viewDir_10 = xlv_TEXCOORD3;
  highp vec3 v_11;
  mediump float tmpvar_12;
  tmpvar_12 = (height_9 - (height_9 / 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(viewDir_10);
  v_11 = tmpvar_13;
  v_11.z = (v_11.z + 0.42);
  highp vec2 tmpvar_14;
  tmpvar_14 = (cloudUV_3 + (tmpvar_12 * (v_11.xy / v_11.z)));
  cloudUV_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Clouds, cloudUV_3);
  c_1.xyz = (((tmpvar_5.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_7)) * tmpvar_7)) + tmpvar_15.xyz) * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz));
  c_1.w = tmpvar_5.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_15).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_3;
  lowp float fresnel_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_4 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = pow (fresnel_4, _AtmosFalloff);
  cloudUV_3 = tmpvar_2;
  highp float tmpvar_8;
  tmpvar_8 = (cloudUV_3.x + (_Time * _CloudSpeed).x);
  cloudUV_3.x = tmpvar_8;
  mediump float height_9;
  height_9 = _CloudHeight;
  mediump vec3 viewDir_10;
  viewDir_10 = xlv_TEXCOORD3;
  highp vec3 v_11;
  mediump float tmpvar_12;
  tmpvar_12 = (height_9 - (height_9 / 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(viewDir_10);
  v_11 = tmpvar_13;
  v_11.z = (v_11.z + 0.42);
  highp vec2 tmpvar_14;
  tmpvar_14 = (cloudUV_3 + (tmpvar_12 * (v_11.xy / v_11.z)));
  cloudUV_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Clouds, cloudUV_3);
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  c_1.xyz = (((tmpvar_5.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_7)) * tmpvar_7)) + tmpvar_15.xyz) * ((8.0 * tmpvar_17.w) * tmpvar_17.xyz));
  c_1.w = tmpvar_5.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_15).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 436
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 457
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    #line 440
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 444
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 448
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 452
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 436
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 457
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 458
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 461
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    #line 465
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 469
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 473
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 477
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 481
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
Vector 19 [_Emission_ST]
Vector 20 [_Clouds_ST]
Vector 21 [_Mask_ST]
"3.0-!!ARBvp1.0
# 23 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
Vector 17 [_Emission_ST]
Vector 18 [_Clouds_ST]
Vector 19 [_Mask_ST]
"vs_3_0
; 24 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c20.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o4.y, r0, r1
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o2.zw, v3.xyxy, c18.xyxy, c18
mad o2.xy, v3, c17, c17.zwzw
mad o3.xy, v3, c19, c19.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  c_1.w = 0.0;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_21;
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_20;
  mediump vec3 specColor_23;
  highp float nh_24;
  mat3 tmpvar_25;
  tmpvar_25[0].x = 0.816497;
  tmpvar_25[0].y = -0.408248;
  tmpvar_25[0].z = -0.408248;
  tmpvar_25[1].x = 0.0;
  tmpvar_25[1].y = 0.707107;
  tmpvar_25[1].z = -0.707107;
  tmpvar_25[2].x = 0.57735;
  tmpvar_25[2].y = 0.57735;
  tmpvar_25[2].z = 0.57735;
  mediump vec3 normal_26;
  normal_26 = tmpvar_18;
  mediump vec3 scalePerBasisVector_27;
  mediump vec3 lm_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_27 = tmpvar_30;
  lm_28 = (lm_28 * dot (clamp ((tmpvar_25 * normal_26), 0.0, 1.0), scalePerBasisVector_27));
  vec3 v_31;
  v_31.x = tmpvar_25[0].x;
  v_31.y = tmpvar_25[1].x;
  v_31.z = tmpvar_25[2].x;
  vec3 v_32;
  v_32.x = tmpvar_25[0].y;
  v_32.y = tmpvar_25[1].y;
  v_32.z = tmpvar_25[2].y;
  vec3 v_33;
  v_33.x = tmpvar_25[0].z;
  v_33.y = tmpvar_25[1].z;
  v_33.z = tmpvar_25[2].z;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, dot (tmpvar_18, normalize((normalize((((scalePerBasisVector_27.x * v_31) + (scalePerBasisVector_27.y * v_32)) + (scalePerBasisVector_27.z * v_33))) + viewDir_22))));
  nh_24 = tmpvar_34;
  highp float tmpvar_35;
  mediump float arg1_36;
  arg1_36 = (tmpvar_3 * 128.0);
  tmpvar_35 = pow (nh_24, arg1_36);
  highp vec3 tmpvar_37;
  tmpvar_37 = (((lm_28 * _SpecColor.xyz) * tmpvar_19) * tmpvar_35);
  specColor_23 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.xyz = lm_28;
  tmpvar_38.w = tmpvar_35;
  tmpvar_21 = tmpvar_38;
  c_1.xyz = specColor_23;
  mediump vec3 tmpvar_39;
  tmpvar_39 = (c_1.xyz + (tmpvar_17 * tmpvar_21.xyz));
  c_1.xyz = tmpvar_39;
  c_1.w = tmpvar_6.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  c_1.w = 0.0;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_LightmapInd, xlv_TEXCOORD4);
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_24;
  mediump vec3 viewDir_25;
  viewDir_25 = tmpvar_23;
  mediump vec3 specColor_26;
  highp float nh_27;
  mat3 tmpvar_28;
  tmpvar_28[0].x = 0.816497;
  tmpvar_28[0].y = -0.408248;
  tmpvar_28[0].z = -0.408248;
  tmpvar_28[1].x = 0.0;
  tmpvar_28[1].y = 0.707107;
  tmpvar_28[1].z = -0.707107;
  tmpvar_28[2].x = 0.57735;
  tmpvar_28[2].y = 0.57735;
  tmpvar_28[2].z = 0.57735;
  mediump vec3 normal_29;
  normal_29 = tmpvar_19;
  mediump vec3 scalePerBasisVector_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = ((8.0 * tmpvar_21.w) * tmpvar_21.xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = ((8.0 * tmpvar_22.w) * tmpvar_22.xyz);
  scalePerBasisVector_30 = tmpvar_33;
  lm_31 = (lm_31 * dot (clamp ((tmpvar_28 * normal_29), 0.0, 1.0), scalePerBasisVector_30));
  vec3 v_34;
  v_34.x = tmpvar_28[0].x;
  v_34.y = tmpvar_28[1].x;
  v_34.z = tmpvar_28[2].x;
  vec3 v_35;
  v_35.x = tmpvar_28[0].y;
  v_35.y = tmpvar_28[1].y;
  v_35.z = tmpvar_28[2].y;
  vec3 v_36;
  v_36.x = tmpvar_28[0].z;
  v_36.y = tmpvar_28[1].z;
  v_36.z = tmpvar_28[2].z;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, dot (tmpvar_19, normalize((normalize((((scalePerBasisVector_30.x * v_34) + (scalePerBasisVector_30.y * v_35)) + (scalePerBasisVector_30.z * v_36))) + viewDir_25))));
  nh_27 = tmpvar_37;
  highp float tmpvar_38;
  mediump float arg1_39;
  arg1_39 = (tmpvar_3 * 128.0);
  tmpvar_38 = pow (nh_27, arg1_39);
  highp vec3 tmpvar_40;
  tmpvar_40 = (((lm_31 * _SpecColor.xyz) * tmpvar_20) * tmpvar_38);
  specColor_26 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41.xyz = lm_31;
  tmpvar_41.w = tmpvar_38;
  tmpvar_24 = tmpvar_41;
  c_1.xyz = specColor_26;
  mediump vec3 tmpvar_42;
  tmpvar_42 = (c_1.xyz + (tmpvar_17 * tmpvar_24.xyz));
  c_1.xyz = tmpvar_42;
  c_1.w = tmpvar_6.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 436
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 457
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    #line 440
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 444
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 448
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 452
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 436
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 457
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 465
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 469
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 473
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 477
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    #line 481
    c.xyz += specColor;
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.xyz += o.Emission;
    #line 485
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_Emission_ST]
Vector 27 [_Clouds_ST]
Vector 28 [_Mask_ST]
"3.0-!!ARBvp1.0
# 52 ALU
PARAM c[29] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..28] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[22];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[5].xyz, R2, R3;
MOV R0.w, c[0].x;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[23].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[28], c[28].zwzw;
END
# 52 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
Vector 26 [_Emission_ST]
Vector 27 [_Clouds_ST]
Vector 28 [_Mask_ST]
"vs_3_0
; 55 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c29, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c29.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.y, r1, c20
dp4 r3.x, r1, c19
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c22
add o6.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c29.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c23.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c29.y
mul r1.y, r1, c13.x
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o7.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
mad o2.zw, v3.xyxy, c27.xyxy, c27
mad o2.xy, v3, c26, c26.zwzw
mad o3.xy, v3, c28, c28.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_7 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float tmpvar_20;
  mediump float lightShadowDataX_21;
  highp float dist_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_22 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = _LightShadowData.x;
  lightShadowDataX_21 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = max (float((dist_22 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_21);
  tmpvar_20 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_27;
  viewDir_27 = tmpvar_26;
  lowp vec4 c_28;
  highp float nh_29;
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_27))));
  nh_29 = tmpvar_31;
  mediump float arg1_32;
  arg1_32 = (tmpvar_3 * 128.0);
  highp float tmpvar_33;
  tmpvar_33 = (pow (nh_29, arg1_32) * tmpvar_19);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_30) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_33)) * (tmpvar_20 * 2.0));
  c_28.xyz = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_33) * tmpvar_20));
  c_28.w = tmpvar_35;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_7 = shlight_3;
  highp vec4 o_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_32.x;
  tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
  o_31.xy = (tmpvar_33 + tmpvar_32.w);
  o_31.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = o_31;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_22;
  lowp vec4 c_24;
  highp float nh_25;
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, xlv_TEXCOORD4));
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_19, normalize((xlv_TEXCOORD4 + viewDir_23))));
  nh_25 = tmpvar_27;
  mediump float arg1_28;
  arg1_28 = (tmpvar_3 * 128.0);
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_25, arg1_28) * tmpvar_20);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_26) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_29)) * (tmpvar_21.x * 2.0));
  c_24.xyz = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_29) * tmpvar_21.x));
  c_24.w = tmpvar_31;
  c_1.w = c_24.w;
  c_1.xyz = (c_24.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 450
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 454
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 458
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 462
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 467
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 469
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 471
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 475
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 479
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 483
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 487
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
Vector 20 [_Emission_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 28 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
Vector 19 [_Emission_ST]
Vector 20 [_Clouds_ST]
Vector 21 [_Mask_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c22.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c22.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o6.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o2.zw, v3.xyxy, c20.xyxy, c20
mad o2.xy, v3, c19, c19.zwzw
mad o3.xy, v3, c21, c21.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_3;
  lowp float fresnel_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_4 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = pow (fresnel_4, _AtmosFalloff);
  cloudUV_3 = tmpvar_2;
  highp float tmpvar_8;
  tmpvar_8 = (cloudUV_3.x + (_Time * _CloudSpeed).x);
  cloudUV_3.x = tmpvar_8;
  mediump float height_9;
  height_9 = _CloudHeight;
  mediump vec3 viewDir_10;
  viewDir_10 = xlv_TEXCOORD3;
  highp vec3 v_11;
  mediump float tmpvar_12;
  tmpvar_12 = (height_9 - (height_9 / 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(viewDir_10);
  v_11 = tmpvar_13;
  v_11.z = (v_11.z + 0.42);
  highp vec2 tmpvar_14;
  tmpvar_14 = (cloudUV_3 + (tmpvar_12 * (v_11.xy / v_11.z)));
  cloudUV_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Clouds, cloudUV_3);
  lowp float tmpvar_16;
  mediump float lightShadowDataX_17;
  highp float dist_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((dist_18 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_17);
  tmpvar_16 = tmpvar_21;
  c_1.xyz = (((tmpvar_5.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_7)) * tmpvar_7)) + tmpvar_15.xyz) * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz), vec3((tmpvar_16 * 2.0))));
  c_1.w = tmpvar_5.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_15).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = o_10;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_3;
  lowp float fresnel_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_4 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = pow (fresnel_4, _AtmosFalloff);
  cloudUV_3 = tmpvar_2;
  highp float tmpvar_8;
  tmpvar_8 = (cloudUV_3.x + (_Time * _CloudSpeed).x);
  cloudUV_3.x = tmpvar_8;
  mediump float height_9;
  height_9 = _CloudHeight;
  mediump vec3 viewDir_10;
  viewDir_10 = xlv_TEXCOORD3;
  highp vec3 v_11;
  mediump float tmpvar_12;
  tmpvar_12 = (height_9 - (height_9 / 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(viewDir_10);
  v_11 = tmpvar_13;
  v_11.z = (v_11.z + 0.42);
  highp vec2 tmpvar_14;
  tmpvar_14 = (cloudUV_3 + (tmpvar_12 * (v_11.xy / v_11.z)));
  cloudUV_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Clouds, cloudUV_3);
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((8.0 * tmpvar_18.w) * tmpvar_18.xyz);
  c_1.xyz = (((tmpvar_5.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_7)) * tmpvar_7)) + tmpvar_15.xyz) * max (min (tmpvar_19, ((tmpvar_17.x * 2.0) * tmpvar_18.xyz)), (tmpvar_19 * tmpvar_17.x)));
  c_1.w = tmpvar_5.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_15).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    #line 449
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 453
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 457
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 461
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 468
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 470
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 474
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 478
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 482
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 486
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 490
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
Vector 20 [_Emission_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 28 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
Vector 19 [_Emission_ST]
Vector 20 [_Clouds_ST]
Vector 21 [_Mask_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c22.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c22.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o6.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o2.zw, v3.xyxy, c20.xyxy, c20
mad o2.xy, v3, c19, c19.zwzw
mad o3.xy, v3, c21, c21.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float tmpvar_20;
  mediump float lightShadowDataX_21;
  highp float dist_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_22 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = _LightShadowData.x;
  lightShadowDataX_21 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = max (float((dist_22 > (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w))), lightShadowDataX_21);
  tmpvar_20 = tmpvar_25;
  c_1.w = 0.0;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_27;
  mediump vec3 viewDir_28;
  viewDir_28 = tmpvar_26;
  mediump vec3 specColor_29;
  highp float nh_30;
  mat3 tmpvar_31;
  tmpvar_31[0].x = 0.816497;
  tmpvar_31[0].y = -0.408248;
  tmpvar_31[0].z = -0.408248;
  tmpvar_31[1].x = 0.0;
  tmpvar_31[1].y = 0.707107;
  tmpvar_31[1].z = -0.707107;
  tmpvar_31[2].x = 0.57735;
  tmpvar_31[2].y = 0.57735;
  tmpvar_31[2].z = 0.57735;
  mediump vec3 normal_32;
  normal_32 = tmpvar_18;
  mediump vec3 scalePerBasisVector_33;
  mediump vec3 lm_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_34 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_33 = tmpvar_36;
  lm_34 = (lm_34 * dot (clamp ((tmpvar_31 * normal_32), 0.0, 1.0), scalePerBasisVector_33));
  vec3 v_37;
  v_37.x = tmpvar_31[0].x;
  v_37.y = tmpvar_31[1].x;
  v_37.z = tmpvar_31[2].x;
  vec3 v_38;
  v_38.x = tmpvar_31[0].y;
  v_38.y = tmpvar_31[1].y;
  v_38.z = tmpvar_31[2].y;
  vec3 v_39;
  v_39.x = tmpvar_31[0].z;
  v_39.y = tmpvar_31[1].z;
  v_39.z = tmpvar_31[2].z;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, dot (tmpvar_18, normalize((normalize((((scalePerBasisVector_33.x * v_37) + (scalePerBasisVector_33.y * v_38)) + (scalePerBasisVector_33.z * v_39))) + viewDir_28))));
  nh_30 = tmpvar_40;
  highp float tmpvar_41;
  mediump float arg1_42;
  arg1_42 = (tmpvar_3 * 128.0);
  tmpvar_41 = pow (nh_30, arg1_42);
  highp vec3 tmpvar_43;
  tmpvar_43 = (((lm_34 * _SpecColor.xyz) * tmpvar_19) * tmpvar_41);
  specColor_29 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.xyz = lm_34;
  tmpvar_44.w = tmpvar_41;
  tmpvar_27 = tmpvar_44;
  c_1.xyz = specColor_29;
  lowp vec3 tmpvar_45;
  tmpvar_45 = vec3((tmpvar_20 * 2.0));
  mediump vec3 tmpvar_46;
  tmpvar_46 = (c_1.xyz + (tmpvar_17 * min (tmpvar_27.xyz, tmpvar_45)));
  c_1.xyz = tmpvar_46;
  c_1.w = tmpvar_6.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = o_10;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_1.w = 0.0;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_Lightmap, xlv_TEXCOORD4);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_LightmapInd, xlv_TEXCOORD4);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_25;
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_24;
  mediump vec3 specColor_27;
  highp float nh_28;
  mat3 tmpvar_29;
  tmpvar_29[0].x = 0.816497;
  tmpvar_29[0].y = -0.408248;
  tmpvar_29[0].z = -0.408248;
  tmpvar_29[1].x = 0.0;
  tmpvar_29[1].y = 0.707107;
  tmpvar_29[1].z = -0.707107;
  tmpvar_29[2].x = 0.57735;
  tmpvar_29[2].y = 0.57735;
  tmpvar_29[2].z = 0.57735;
  mediump vec3 normal_30;
  normal_30 = tmpvar_19;
  mediump vec3 scalePerBasisVector_31;
  mediump vec3 lm_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = ((8.0 * tmpvar_22.w) * tmpvar_22.xyz);
  lm_32 = tmpvar_33;
  lowp vec3 tmpvar_34;
  tmpvar_34 = ((8.0 * tmpvar_23.w) * tmpvar_23.xyz);
  scalePerBasisVector_31 = tmpvar_34;
  lm_32 = (lm_32 * dot (clamp ((tmpvar_29 * normal_30), 0.0, 1.0), scalePerBasisVector_31));
  vec3 v_35;
  v_35.x = tmpvar_29[0].x;
  v_35.y = tmpvar_29[1].x;
  v_35.z = tmpvar_29[2].x;
  vec3 v_36;
  v_36.x = tmpvar_29[0].y;
  v_36.y = tmpvar_29[1].y;
  v_36.z = tmpvar_29[2].y;
  vec3 v_37;
  v_37.x = tmpvar_29[0].z;
  v_37.y = tmpvar_29[1].z;
  v_37.z = tmpvar_29[2].z;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, dot (tmpvar_19, normalize((normalize((((scalePerBasisVector_31.x * v_35) + (scalePerBasisVector_31.y * v_36)) + (scalePerBasisVector_31.z * v_37))) + viewDir_26))));
  nh_28 = tmpvar_38;
  highp float tmpvar_39;
  mediump float arg1_40;
  arg1_40 = (tmpvar_3 * 128.0);
  tmpvar_39 = pow (nh_28, arg1_40);
  highp vec3 tmpvar_41;
  tmpvar_41 = (((lm_32 * _SpecColor.xyz) * tmpvar_20) * tmpvar_39);
  specColor_27 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42.xyz = lm_32;
  tmpvar_42.w = tmpvar_39;
  tmpvar_25 = tmpvar_42;
  c_1.xyz = specColor_27;
  lowp vec3 arg1_43;
  arg1_43 = ((tmpvar_21.x * 2.0) * tmpvar_22.xyz);
  mediump vec3 tmpvar_44;
  tmpvar_44 = (c_1.xyz + (tmpvar_17 * max (min (tmpvar_25.xyz, arg1_43), (tmpvar_25.xyz * tmpvar_21.x))));
  c_1.xyz = tmpvar_44;
  c_1.w = tmpvar_6.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 469
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    #line 449
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 453
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 457
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 461
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 469
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 469
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 473
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 477
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 481
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 485
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 489
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    c.xyz += specColor;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 493
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
Vector 33 [_Emission_ST]
Vector 34 [_Clouds_ST]
Vector 35 [_Mask_ST]
"3.0-!!ARBvp1.0
# 78 ALU
PARAM c[36] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..35] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
MOV R0.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[29];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[5].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[30].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[34].xyxy, c[34];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[35], c[35].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 78 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
Vector 32 [_Emission_ST]
Vector 33 [_Clouds_ST]
Vector 34 [_Mask_ST]
"vs_3_0
; 81 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c35, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c35.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c35.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o6.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c35.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
mad o2.zw, v3.xyxy, c33.xyxy, c33
mad o2.xy, v3, c32, c32.zwzw
mad o3.xy, v3, c34, c34.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_7 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_7 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_7 = tmpvar_37;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_21;
  viewDir_21 = tmpvar_20;
  lowp vec4 c_22;
  highp float nh_23;
  lowp float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_21))));
  nh_23 = tmpvar_25;
  mediump float arg1_26;
  arg1_26 = (tmpvar_3 * 128.0);
  highp float tmpvar_27;
  tmpvar_27 = (pow (nh_23, arg1_26) * tmpvar_19);
  highp vec3 tmpvar_28;
  tmpvar_28 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_24) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_27)) * 2.0);
  c_22.xyz = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_6.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_27));
  c_22.w = tmpvar_29;
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_7 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_7 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_7 = tmpvar_37;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_21;
  lowp vec4 c_23;
  highp float nh_24;
  lowp float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_19, xlv_TEXCOORD4));
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, normalize((xlv_TEXCOORD4 + viewDir_22))));
  nh_24 = tmpvar_26;
  mediump float arg1_27;
  arg1_27 = (tmpvar_3 * 128.0);
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_24, arg1_27) * tmpvar_20);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_25) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_28)) * 2.0);
  c_23.xyz = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (tmpvar_6.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_28));
  c_23.w = tmpvar_30;
  c_1.w = c_23.w;
  c_1.xyz = (c_23.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
#line 461
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 441
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 445
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 449
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    #line 457
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
#line 461
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 461
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 465
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 469
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 473
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 477
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 481
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
Vector 34 [_Emission_ST]
Vector 35 [_Clouds_ST]
Vector 36 [_Mask_ST]
"3.0-!!ARBvp1.0
# 83 ALU
PARAM c[37] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..36] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R3, R3;
MOV R0.w, c[0].x;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[5].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[31].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[35].xyxy, c[35];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[36], c[36].zwzw;
END
# 83 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
Vector 34 [_Emission_ST]
Vector 35 [_Clouds_ST]
Vector 36 [_Mask_ST]
"vs_3_0
; 86 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c37, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c37.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c37.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c37.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o6.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c37.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c31.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c37.z
mul r1.y, r1, c13.x
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o7.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
mad o2.zw, v3.xyxy, c35.xyxy, c35
mad o2.xy, v3, c34, c34.zwzw
mad o3.xy, v3, c36, c36.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_7 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_7 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_7 = tmpvar_37;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float tmpvar_20;
  mediump float lightShadowDataX_21;
  highp float dist_22;
  lowp float tmpvar_23;
  tmpvar_23 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_22 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = _LightShadowData.x;
  lightShadowDataX_21 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = max (float((dist_22 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_21);
  tmpvar_20 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_27;
  viewDir_27 = tmpvar_26;
  lowp vec4 c_28;
  highp float nh_29;
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_27))));
  nh_29 = tmpvar_31;
  mediump float arg1_32;
  arg1_32 = (tmpvar_3 * 128.0);
  highp float tmpvar_33;
  tmpvar_33 = (pow (nh_29, arg1_32) * tmpvar_19);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_30) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_33)) * (tmpvar_20 * 2.0));
  c_28.xyz = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_33) * tmpvar_20));
  c_28.w = tmpvar_35;
  c_1.w = c_28.w;
  c_1.xyz = (c_28.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_1.xyz;
  tmpvar_12 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_2.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_2.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_2.z;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_10;
  mediump vec3 tmpvar_17;
  mediump vec4 normal_18;
  normal_18 = tmpvar_16;
  highp float vC_19;
  mediump vec3 x3_20;
  mediump vec3 x2_21;
  mediump vec3 x1_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAr, normal_18);
  x1_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAg, normal_18);
  x1_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHAb, normal_18);
  x1_22.z = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_18.xyzz * normal_18.yzzx);
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBr, tmpvar_26);
  x2_21.x = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBg, tmpvar_26);
  x2_21.y = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = dot (unity_SHBb, tmpvar_26);
  x2_21.z = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = ((normal_18.x * normal_18.x) - (normal_18.y * normal_18.y));
  vC_19 = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_SHC.xyz * vC_19);
  x3_20 = tmpvar_31;
  tmpvar_17 = ((x1_22 + x2_21) + x3_20);
  shlight_3 = tmpvar_17;
  tmpvar_7 = shlight_3;
  highp vec3 tmpvar_32;
  tmpvar_32 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosX0 - tmpvar_32.x);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosY0 - tmpvar_32.y);
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosZ0 - tmpvar_32.z);
  highp vec4 tmpvar_36;
  tmpvar_36 = (((tmpvar_33 * tmpvar_33) + (tmpvar_34 * tmpvar_34)) + (tmpvar_35 * tmpvar_35));
  highp vec4 tmpvar_37;
  tmpvar_37 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_33 * tmpvar_10.x) + (tmpvar_34 * tmpvar_10.y)) + (tmpvar_35 * tmpvar_10.z)) * inversesqrt(tmpvar_36))) * (1.0/((1.0 + (tmpvar_36 * unity_4LightAtten0)))));
  highp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_7 + ((((unity_LightColor[0].xyz * tmpvar_37.x) + (unity_LightColor[1].xyz * tmpvar_37.y)) + (unity_LightColor[2].xyz * tmpvar_37.z)) + (unity_LightColor[3].xyz * tmpvar_37.w)));
  tmpvar_7 = tmpvar_38;
  highp vec4 o_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_41;
  tmpvar_41.x = tmpvar_40.x;
  tmpvar_41.y = (tmpvar_40.y * _ProjectionParams.x);
  o_39.xy = (tmpvar_41 + tmpvar_40.w);
  o_39.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_13 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = o_39;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (normal_18, vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_22;
  lowp vec4 c_24;
  highp float nh_25;
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, xlv_TEXCOORD4));
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_19, normalize((xlv_TEXCOORD4 + viewDir_23))));
  nh_25 = tmpvar_27;
  mediump float arg1_28;
  arg1_28 = (tmpvar_3 * 128.0);
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_25, arg1_28) * tmpvar_20);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_26) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_29)) * (tmpvar_21.x * 2.0));
  c_24.xyz = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_29) * tmpvar_21.x));
  c_24.w = tmpvar_31;
  c_1.w = c_24.w;
  c_1.xyz = (c_24.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 471
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 450
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 454
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 458
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 462
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    #line 466
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 471
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 471
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 475
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 479
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 483
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 487
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 491
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_7 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float shadow_20;
  lowp float tmpvar_21;
  tmpvar_21 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_22;
  tmpvar_22 = (_LightShadowData.x + (tmpvar_21 * (1.0 - _LightShadowData.x)));
  shadow_20 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_23;
  lowp vec4 c_25;
  highp float nh_26;
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_24))));
  nh_26 = tmpvar_28;
  mediump float arg1_29;
  arg1_29 = (tmpvar_3 * 128.0);
  highp float tmpvar_30;
  tmpvar_30 = (pow (nh_26, arg1_29) * tmpvar_19);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_27) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_30)) * (shadow_20 * 2.0));
  c_25.xyz = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_30) * shadow_20));
  c_25.w = tmpvar_32;
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 450
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 454
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 458
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 462
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 467
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 469
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 471
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 475
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 479
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 483
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 487
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_3;
  lowp float fresnel_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_4 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = pow (fresnel_4, _AtmosFalloff);
  cloudUV_3 = tmpvar_2;
  highp float tmpvar_8;
  tmpvar_8 = (cloudUV_3.x + (_Time * _CloudSpeed).x);
  cloudUV_3.x = tmpvar_8;
  mediump float height_9;
  height_9 = _CloudHeight;
  mediump vec3 viewDir_10;
  viewDir_10 = xlv_TEXCOORD3;
  highp vec3 v_11;
  mediump float tmpvar_12;
  tmpvar_12 = (height_9 - (height_9 / 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(viewDir_10);
  v_11 = tmpvar_13;
  v_11.z = (v_11.z + 0.42);
  highp vec2 tmpvar_14;
  tmpvar_14 = (cloudUV_3 + (tmpvar_12 * (v_11.xy / v_11.z)));
  cloudUV_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Clouds, cloudUV_3);
  lowp float shadow_16;
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_18;
  tmpvar_18 = (_LightShadowData.x + (tmpvar_17 * (1.0 - _LightShadowData.x)));
  shadow_16 = tmpvar_18;
  c_1.xyz = (((tmpvar_5.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_7)) * tmpvar_7)) + tmpvar_15.xyz) * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz), vec3((shadow_16 * 2.0))));
  c_1.w = tmpvar_5.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_15).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    #line 449
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 453
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 457
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 461
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 468
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 470
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 474
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 478
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 482
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 486
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 490
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float shadow_20;
  lowp float tmpvar_21;
  tmpvar_21 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_22;
  tmpvar_22 = (_LightShadowData.x + (tmpvar_21 * (1.0 - _LightShadowData.x)));
  shadow_20 = tmpvar_22;
  c_1.w = 0.0;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_24;
  mediump vec3 viewDir_25;
  viewDir_25 = tmpvar_23;
  mediump vec3 specColor_26;
  highp float nh_27;
  mat3 tmpvar_28;
  tmpvar_28[0].x = 0.816497;
  tmpvar_28[0].y = -0.408248;
  tmpvar_28[0].z = -0.408248;
  tmpvar_28[1].x = 0.0;
  tmpvar_28[1].y = 0.707107;
  tmpvar_28[1].z = -0.707107;
  tmpvar_28[2].x = 0.57735;
  tmpvar_28[2].y = 0.57735;
  tmpvar_28[2].z = 0.57735;
  mediump vec3 normal_29;
  normal_29 = tmpvar_18;
  mediump vec3 scalePerBasisVector_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD4).xyz);
  scalePerBasisVector_30 = tmpvar_33;
  lm_31 = (lm_31 * dot (clamp ((tmpvar_28 * normal_29), 0.0, 1.0), scalePerBasisVector_30));
  vec3 v_34;
  v_34.x = tmpvar_28[0].x;
  v_34.y = tmpvar_28[1].x;
  v_34.z = tmpvar_28[2].x;
  vec3 v_35;
  v_35.x = tmpvar_28[0].y;
  v_35.y = tmpvar_28[1].y;
  v_35.z = tmpvar_28[2].y;
  vec3 v_36;
  v_36.x = tmpvar_28[0].z;
  v_36.y = tmpvar_28[1].z;
  v_36.z = tmpvar_28[2].z;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, dot (tmpvar_18, normalize((normalize((((scalePerBasisVector_30.x * v_34) + (scalePerBasisVector_30.y * v_35)) + (scalePerBasisVector_30.z * v_36))) + viewDir_25))));
  nh_27 = tmpvar_37;
  highp float tmpvar_38;
  mediump float arg1_39;
  arg1_39 = (tmpvar_3 * 128.0);
  tmpvar_38 = pow (nh_27, arg1_39);
  highp vec3 tmpvar_40;
  tmpvar_40 = (((lm_31 * _SpecColor.xyz) * tmpvar_19) * tmpvar_38);
  specColor_26 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41.xyz = lm_31;
  tmpvar_41.w = tmpvar_38;
  tmpvar_24 = tmpvar_41;
  c_1.xyz = specColor_26;
  lowp vec3 tmpvar_42;
  tmpvar_42 = vec3((shadow_20 * 2.0));
  mediump vec3 tmpvar_43;
  tmpvar_43 = (c_1.xyz + (tmpvar_17 * min (tmpvar_24.xyz, tmpvar_42)));
  c_1.xyz = tmpvar_43;
  c_1.w = tmpvar_6.w;
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 469
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    #line 449
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 453
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    #line 457
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 461
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 465
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec2(xl_retval.lmap);
    xlv_TEXCOORD5 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 441
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 445
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 469
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 469
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 473
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 477
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 481
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 485
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 489
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor).xyz;
    c.xyz += specColor;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 493
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lmap = vec2(xlv_TEXCOORD4);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_6 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_7 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_7 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_7 = tmpvar_37;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_3;
  mediump vec2 cloudUV_4;
  lowp float fresnel_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  tmpvar_7 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_5 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = pow (fresnel_5, _AtmosFalloff);
  cloudUV_4 = tmpvar_2;
  highp float tmpvar_9;
  tmpvar_9 = (cloudUV_4.x + (_Time * _CloudSpeed).x);
  cloudUV_4.x = tmpvar_9;
  mediump float height_10;
  height_10 = _CloudHeight;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD3;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = (height_10 - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (cloudUV_4 + (tmpvar_13 * (v_12.xy / v_12.z)));
  cloudUV_4 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Clouds, cloudUV_4);
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_6.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_8)) * tmpvar_8)) + tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_16.xyz);
  tmpvar_3 = _Shininess;
  lowp float tmpvar_19;
  tmpvar_19 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_16)) * _SpecColor).x;
  lowp float shadow_20;
  lowp float tmpvar_21;
  tmpvar_21 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_22;
  tmpvar_22 = (_LightShadowData.x + (tmpvar_21 * (1.0 - _LightShadowData.x)));
  shadow_20 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_23;
  lowp vec4 c_25;
  highp float nh_26;
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_18, xlv_TEXCOORD4));
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_18, normalize((xlv_TEXCOORD4 + viewDir_24))));
  nh_26 = tmpvar_28;
  mediump float arg1_29;
  arg1_29 = (tmpvar_3 * 128.0);
  highp float tmpvar_30;
  tmpvar_30 = (pow (nh_26, arg1_29) * tmpvar_19);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((((tmpvar_17 * _LightColor0.xyz) * tmpvar_27) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_30)) * (shadow_20 * 2.0));
  c_25.xyz = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_6.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_30) * shadow_20));
  c_25.w = tmpvar_32;
  c_1.w = c_25.w;
  c_1.xyz = (c_25.xyz + (tmpvar_17 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_16).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 471
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 450
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 454
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 458
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    #line 462
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    #line 466
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out lowp vec3 xlv_TEXCOORD4;
out lowp vec3 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
    xlv_TEXCOORD6 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 430
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 401
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 412
#line 442
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 446
uniform highp vec4 _Mask_ST;
#line 471
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 412
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 416
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 420
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 424
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 428
    o.Alpha = c.w;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 471
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 475
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 479
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 483
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 487
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingBlinnPhong( o, IN.lightDir, normalize(IN.viewDir), atten);
    c.xyz += (o.Albedo * IN.vlight);
    #line 491
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in lowp vec3 xlv_TEXCOORD4;
in lowp vec3 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 34 to 80, TEX: 4 to 8
//   d3d9 - ALU: 33 to 77, TEX: 4 to 8
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_LightAmount]
Float 4 [_AtmosFalloff]
Float 5 [_CloudSpeed]
Float 6 [_CloudHeight]
Float 7 [_Shininess]
Vector 8 [_AtmosNear]
Vector 9 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
"3.0-!!ARBfp1.0
# 65 ALU, 5 TEX
PARAM c[12] = { program.local[0..9],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MAD R2.xy, R2.wyzw, c[10].w, -c[10].x;
RSQ R0.x, R0.x;
MOV R1.xyz, fragment.texcoord[4];
MAD R1.xyz, fragment.texcoord[3], R0.x, R1;
DP3 R0.y, R1, R1;
RSQ R0.w, R0.y;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R0.z, R0, c[10];
RCP R0.z, R0.z;
MUL R1.xyz, R0.w, R1;
MUL R0.xy, R0, R0.z;
MUL R0.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R0, R0.w;
MOV R1.w, c[10].y;
MAD R0.z, -R1.w, c[6].x, c[6].x;
MUL R0.zw, R0.z, R0.xyxy;
ADD R0.y, -R2.z, c[10].x;
RSQ R0.y, R0.y;
RCP R2.z, R0.y;
MOV R0.x, c[5];
MUL R0.x, R0, c[0];
ADD R3.xyz, -R2, c[11].xxyw;
ADD R0.x, fragment.texcoord[1].z, R0;
MOV R0.y, fragment.texcoord[1].w;
ADD R0.xy, R0, R0.zwzw;
TEX R0.xyz, R0, texture[1], 2D;
MAD R3.xyz, R0, R3, R2;
DP3 R0.w, R3, R1;
MAX R1.y, R0.w, c[11].x;
MOV R0.w, c[11].z;
MUL R0.w, R0, c[7].x;
ADD R1.z, -R0.x, c[10].x;
TEX R1.x, fragment.texcoord[2], texture[4], 2D;
MUL R1.x, R1, R1.z;
POW R0.w, R1.y, R0.w;
MUL R1.y, R1.x, c[2].x;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MUL_SAT R1.w, R1.x, fragment.texcoord[3].z;
MUL R0.w, R0, R1.y;
MOV R1.xyz, c[8];
ADD R1.w, -R1, c[10].x;
TEX R2, fragment.texcoord[0], texture[0], 2D;
POW R1.w, R1.w, c[4].x;
ADD R1.xyz, -R1, c[9];
MAD R1.xyz, R1.w, R1, c[8];
MAD R1.xyz, R1, R1.w, R2;
DP3 R1.w, R3, fragment.texcoord[4];
ADD R2.xyz, R1, R0;
MAX R3.w, R1, c[11].x;
MUL R3.xyz, R2, c[1];
MOV R1, c[2];
MUL R1.xyz, R1, c[1];
MUL R3.xyz, R3, R3.w;
MAD R3.xyz, R1, R0.w, R3;
TEX R1.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R1.xyz, R1, c[3].x;
MAD R0.xyz, R0, -R1, R1;
MUL R3.xyz, R3, c[10].w;
MAD R2.xyz, R2, fragment.texcoord[5], R3;
MUL R1.x, R1.w, c[1].w;
ADD result.color.xyz, R2, R0;
MAD result.color.w, R0, R1.x, R2;
END
# 65 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_LightAmount]
Float 4 [_AtmosFalloff]
Float 5 [_CloudSpeed]
Float 6 [_CloudHeight]
Float 7 [_Shininess]
Vector 8 [_AtmosNear]
Vector 9 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
"ps_3_0
; 67 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c10, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c11, 2.00000000, -1.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.w, r0.x
mov_pp r1.xyz, v4
mad_pp r0.xyz, v3, r0.w, r1
mov_pp r4.xyz, c9
mul_pp r2.xyz, r0.w, v3
dp3_pp r1.x, r0, r0
rsq_pp r0.w, r1.x
mul_pp r0.xyz, r0.w, r0
add r1.x, r2.z, c10.z
texld r1.yw, v0.zwzw, s2
rcp r1.z, r1.x
mad_pp r1.xy, r1.wyzw, c11.x, c11.y
mul_pp r2.zw, r1.xyxy, r1.xyxy
mul r1.zw, r2.xyxy, r1.z
add_pp_sat r2.z, r2, r2.w
mov_pp r2.x, c10.y
mad_pp r2.x, r2, c6, c6
mul r2.xy, r2.x, r1.zwzw
add_pp r1.w, -r2.z, c10.x
rsq_pp r2.z, r1.w
mov r1.z, c0.x
mul r1.w, c5.x, r1.z
rcp_pp r1.z, r2.z
add_pp r3.xyz, -r1, c10.wwxw
add_pp r2.z, v1, r1.w
mov_pp r2.w, v1
add_pp r2.xy, r2.zwzw, r2
texld r2.xyz, r2, s1
mad_pp r3.xyz, r2, r3, r1
dp3_pp r0.x, r3, r0
mov_pp r0.w, c7.x
mul_pp r1.y, c11.z, r0.w
max_pp r1.x, r0, c10.w
pow r0, r1.x, r1.y
mov r0.z, r0.x
texld r1, v0, s0
dp3 r0.y, v3, v3
texld r0.x, v2, s4
add_pp r0.w, -r2.x, c10.x
mul r0.w, r0.x, r0
rsq r0.x, r0.y
mul r0.y, r0.w, c2.x
mul_sat r0.x, r0, v3.z
mul r2.w, r0.z, r0.y
add r3.w, -r0.x, c10.x
pow_pp r0, r3.w, c4.x
mov_pp r0.w, r0.x
add_pp r4.xyz, -c8, r4
mad_pp r0.xyz, r0.w, r4, c8
mad_pp r0.xyz, r0, r0.w, r1
dp3_pp r0.w, r3, v4
add_pp r0.xyz, r0, r2
mov_pp r1.xyz, c1
max_pp r0.w, r0, c10
mul_pp r3.xyz, r0, c1
mul_pp r3.xyz, r3, r0.w
mul_pp r1.xyz, c2, r1
mad r1.xyz, r1, r2.w, r3
mul r3.xyz, r1, c11.x
texld r1.xyz, v1, s3
mul r1.xyz, r1, c3.x
mov_pp r0.w, c1
mul_pp r0.w, c2, r0
mad_pp r0.xyz, r0, v5, r3
mad r1.xyz, r2, -r1, r1
add_pp oC0.xyz, r0, r1
mad oC0.w, r2, r0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Float 1 [_LightAmount]
Float 2 [_AtmosFalloff]
Float 3 [_CloudSpeed]
Float 4 [_CloudHeight]
Vector 5 [_AtmosNear]
Vector 6 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 34 ALU, 4 TEX
PARAM c[8] = { program.local[0..6],
		{ 0.5, 1, 0.41999999, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R0.z, R0, c[7];
RCP R0.z, R0.z;
MUL R0.zw, R0.xyxy, R0.z;
MOV R0.x, c[7];
MAD R0.x, -R0, c[4], c[4];
MUL R1.xy, R0.x, R0.zwzw;
MOV R0.y, c[3].x;
MUL R0.x, R0.y, c[0];
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.z, R0.z;
MUL_SAT R0.z, R0, fragment.texcoord[3];
MOV R2.xyz, c[5];
ADD R0.z, -R0, c[7].y;
POW R0.z, R0.z, c[2].x;
ADD R2.xyz, -R2, c[6];
MAD R2.xyz, R0.z, R2, c[5];
ADD R0.x, fragment.texcoord[1].z, R0;
MOV R0.y, fragment.texcoord[1].w;
ADD R0.xy, R0, R1;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MAD R2.xyz, R2, R0.z, R1;
TEX R1.xyz, R0, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R3.xyz, R0, c[1].x;
ADD R2.xyz, R2, R1;
TEX R0, fragment.texcoord[4], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MAD R1.xyz, R1, -R3, R3;
MUL R0.xyz, R0, R2;
MAD result.color.xyz, R0, c[7].w, R1;
MOV result.color.w, R1;
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Float 1 [_LightAmount]
Float 2 [_AtmosFalloff]
Float 3 [_CloudSpeed]
Float 4 [_CloudHeight]
Vector 5 [_AtmosNear]
Vector 6 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 33 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
def c7, 1.00000000, 0.41999999, -0.50000000, 8.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v3
add r0.x, r1.z, c7.y
rcp r0.y, r0.x
mul r0.zw, r1.xyxy, r0.y
mov_pp r0.x, c7.z
mad_pp r0.x, r0, c4, c4
mul r1.xy, r0.x, r0.zwzw
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul_sat r0.z, r0.x, v3
mov r0.y, c0.x
mul r0.y, c3.x, r0
add_pp r0.x, v1.z, r0.y
mov_pp r0.y, v1.w
add_pp r3.xy, r0, r1
add r2.x, -r0.z, c7
pow_pp r0, r2.x, c2.x
texld r1, v0, s0
mov_pp r2.xyz, c6
mov_pp r0.w, r0.x
add_pp r2.xyz, -c5, r2
mad_pp r0.xyz, r0.w, r2, c5
mad_pp r2.xyz, r0, r0.w, r1
texld r1.xyz, r3, s1
texld r0.xyz, v1, s3
mul r3.xyz, r0, c1.x
add_pp r2.xyz, r2, r1
texld r0, v4, s4
mul_pp r0.xyz, r0.w, r0
mad r1.xyz, r1, -r3, r3
mul_pp r0.xyz, r0, r2
mad_pp oC0.xyz, r0, c7.w, r1
mov_pp oC0.w, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 74 ALU, 7 TEX
PARAM c[13] = { program.local[0..8],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 0.81649655, 0.57735026 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.x;
MUL R1.xyz, R0.w, fragment.texcoord[3];
ADD R0.x, R1.z, c[9].z;
RCP R0.z, R0.x;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R3.wyzw, c[9].w, -c[9].x;
MUL R1.xy, R1, R0.z;
MUL R1.zw, R0.xyxy, R0.xyxy;
ADD_SAT R1.z, R1, R1.w;
TEX R2, fragment.texcoord[4], texture[6], 2D;
MUL R2.xyz, R2.w, R2;
ADD R1.z, -R1, c[9].x;
MOV R0.z, c[9].y;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.xy, R0.z, R1;
MUL R4.xyz, R2, c[11].w;
RSQ R1.w, R1.z;
MOV R0.z, c[4].x;
MUL R1.z, R0, c[0].x;
RCP R0.z, R1.w;
ADD R3.xyz, -R0, c[10].xxyw;
ADD R1.z, fragment.texcoord[1], R1;
MOV R1.w, fragment.texcoord[1];
ADD R1.xy, R1.zwzw, R1;
TEX R1.xyz, R1, texture[1], 2D;
MAD R0.xyz, R1, R3, R0;
MUL R3.xyz, R4.y, c[12];
MAD R3.xyz, R4.x, c[10].zxww, R3;
MAD R3.xyz, R4.z, c[11], R3;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
MAD R3.xyz, fragment.texcoord[3], R0.w, R3;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
DP3_SAT R2.z, R0, c[11];
DP3_SAT R2.y, R0, c[12];
DP3_SAT R2.x, R0, c[10].zxww;
DP3 R3.w, R2, R4;
MUL R3.xyz, R1.w, R3;
DP3 R0.y, R0, R3;
MOV R0.x, c[12].w;
MUL R0.z, R0.x, c[6].x;
TEX R2, fragment.texcoord[4], texture[5], 2D;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.w;
MUL R4.xyz, R2, c[11].w;
MAX R0.y, R0, c[10].x;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
ADD R0.w, -R1.x, c[9].x;
TEX R5.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.w, R5.x, R0;
MUL R0.w, R0, c[1].x;
MUL R2.xyz, R4, c[1];
MUL R2.xyz, R2, R0.w;
POW R0.y, R0.y, R0.z;
MUL R5.xyz, R2, R0.y;
RSQ R0.x, R0.x;
MUL_SAT R0.w, R0.x, fragment.texcoord[3].z;
ADD R0.w, -R0, c[9].x;
MOV R0.xyz, c[7];
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
POW R1.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[8];
MAD R3.xyz, R1.w, R0, c[7];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R3, R1.w, R0;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[2].x;
MAD R1.xyz, R1, -R2, R2;
MAD R0.xyz, R0, R4, R5;
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 74 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"ps_3_0
; 72 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c9, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c10, 2.00000000, -1.00000000, 8.00000000, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 0
def c12, -0.40824831, 0.70710677, 0.57735026, 0
def c13, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dp3_pp r0.x, v3, v3
rsq_pp r0.w, r0.x
mul_pp r1.xyz, r0.w, v3
add r0.x, r1.z, c9.z
rcp r0.z, r0.x
texld r3.yw, v0.zwzw, s2
mad_pp r0.xy, r3.wyzw, c10.x, c10.y
mul r1.xy, r1, r0.z
mul_pp r1.zw, r0.xyxy, r0.xyxy
add_pp_sat r1.z, r1, r1.w
texld r2, v4, s6
mul_pp r2.xyz, r2.w, r2
add_pp r1.z, -r1, c9.x
mov_pp r0.z, c9.y
mad_pp r0.z, r0, c5.x, c5.x
mul r1.xy, r0.z, r1
mul_pp r4.xyz, r2, c10.z
rsq_pp r1.w, r1.z
mov r0.z, c0.x
mul r1.z, c4.x, r0
rcp_pp r0.z, r1.w
add_pp r3.xyz, -r0, c9.wwxw
add_pp r1.z, v1, r1
mov_pp r1.w, v1
add_pp r1.xy, r1.zwzw, r1
texld r1.xyz, r1, s1
mad_pp r0.xyz, r1, r3, r0
mul r3.xyz, r4.y, c12
mad r3.xyz, r4.x, c13, r3
mad r3.xyz, r4.z, c11, r3
dp3 r1.w, r3, r3
rsq r1.w, r1.w
mul r3.xyz, r1.w, r3
mad_pp r3.xyz, v3, r0.w, r3
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp_sat r2.z, r0, c11
dp3_pp_sat r2.y, r0, c12
dp3_pp_sat r2.x, r0, c13
dp3_pp r0.x, r0, r3
dp3_pp r3.w, r2, r4
texld r2, v4, s5
mul_pp r2.xyz, r2.w, r2
mul_pp r2.xyz, r2, r3.w
mul_pp r4.xyz, r2, c10.z
mov_pp r0.y, c6.x
mul_pp r3.x, c10.w, r0.y
add_pp r0.w, -r1.x, c9.x
texld r5.x, v2, s4
mul r0.w, r5.x, r0
mul r0.w, r0, c1.x
mul_pp r2.xyz, r4, c1
mul_pp r2.xyz, r2, r0.w
max_pp r2.w, r0.x, c9
pow r0, r2.w, r3.x
dp3 r1.w, v3, v3
rsq r0.y, r1.w
mul r5.xyz, r2, r0.x
mul_sat r0.y, r0, v3.z
add r1.w, -r0.y, c9.x
pow_pp r0, r1.w, c3.x
mov_pp r1.w, r0.x
texld r0, v0, s0
mov_pp r2.xyz, c8
add_pp r2.xyz, -c7, r2
mad_pp r3.xyz, r1.w, r2, c7
texld r2.xyz, v1, s3
mad_pp r0.xyz, r3, r1.w, r0
add_pp r0.xyz, r0, r1
mul r2.xyz, r2, c2.x
mad r1.xyz, r1, -r2, r2
mad_pp r0.xyz, r0, r4, r5
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_LightAmount]
Float 4 [_AtmosFalloff]
Float 5 [_CloudSpeed]
Float 6 [_CloudHeight]
Float 7 [_Shininess]
Vector 8 [_AtmosNear]
Vector 9 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 68 ALU, 6 TEX
PARAM c[12] = { program.local[0..9],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[3];
ADD R0.w, R3.z, c[10].z;
MOV R1.xyz, fragment.texcoord[4];
MAD R1.xyz, fragment.texcoord[3], R0.x, R1;
DP3 R0.y, R1, R1;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, R1;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R2.xy, R1.wyzw, c[10].w, -c[10].x;
MUL R1.zw, R2.xyxy, R2.xyxy;
ADD_SAT R1.z, R1, R1.w;
RCP R0.w, R0.w;
MUL R1.xy, R3, R0.w;
MOV R0.w, c[10].y;
MAD R0.w, -R0, c[6].x, c[6].x;
MUL R1.xy, R0.w, R1;
ADD R1.z, -R1, c[10].x;
RSQ R1.z, R1.z;
RCP R2.z, R1.z;
MOV R0.w, c[5].x;
MUL R0.w, R0, c[0].x;
ADD R1.z, fragment.texcoord[1], R0.w;
MOV R1.w, fragment.texcoord[1];
ADD R1.xy, R1.zwzw, R1;
TEX R1.xyz, R1, texture[1], 2D;
ADD R3.xyz, -R2, c[11].xxyw;
MAD R3.xyz, R1, R3, R2;
DP3 R0.x, R3, R0;
MAX R0.y, R0.x, c[11].x;
MOV R0.x, c[11].z;
MUL R0.z, R0.x, c[7].x;
POW R0.y, R0.y, R0.z;
ADD R0.w, -R1.x, c[10].x;
TEX R0.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.x, R0, R0.w;
MUL R0.z, R0.x, c[2].x;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.x, R0.x;
MUL_SAT R2.w, R2.x, fragment.texcoord[3].z;
MUL R1.w, R0.y, R0.z;
MOV R2.xyz, c[8];
ADD R2.w, -R2, c[10].x;
POW R2.w, R2.w, c[4].x;
ADD R2.xyz, -R2, c[9];
MAD R2.xyz, R2.w, R2, c[8];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R2, R2.w, R0;
DP3 R2.x, R3, fragment.texcoord[4];
ADD R3.xyz, R0, R1;
MUL R0.xyz, R3, c[1];
MAX R2.x, R2, c[11];
MUL R4.xyz, R0, R2.x;
MOV R2, c[2];
TXP R0.x, fragment.texcoord[6], texture[5], 2D;
MUL R2.xyz, R2, c[1];
MAD R2.xyz, R2, R1.w, R4;
MUL R0.y, R0.x, c[10].w;
MUL R4.xyz, R2, R0.y;
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R2.xyz, R2, c[3].x;
MUL R0.y, R2.w, c[1].w;
MUL R0.y, R1.w, R0;
MAD R3.xyz, R3, fragment.texcoord[5], R4;
MAD R1.xyz, R1, -R2, R2;
ADD result.color.xyz, R3, R1;
MAD result.color.w, R0.x, R0.y, R0;
END
# 68 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_LightAmount]
Float 4 [_AtmosFalloff]
Float 5 [_CloudSpeed]
Float 6 [_CloudHeight]
Float 7 [_Shininess]
Vector 8 [_AtmosNear]
Vector 9 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 69 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c10, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c11, 2.00000000, -1.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
dp3_pp r0.x, v3, v3
rsq_pp r0.w, r0.x
mov_pp r1.xyz, v4
mad_pp r0.xyz, v3, r0.w, r1
mov_pp r4.xyz, c9
mul_pp r2.xyz, r0.w, v3
dp3_pp r1.x, r0, r0
rsq_pp r0.w, r1.x
mul_pp r0.xyz, r0.w, r0
add r1.x, r2.z, c10.z
texld r1.yw, v0.zwzw, s2
rcp r1.z, r1.x
mad_pp r1.xy, r1.wyzw, c11.x, c11.y
mul_pp r2.zw, r1.xyxy, r1.xyxy
mul r1.zw, r2.xyxy, r1.z
add_pp_sat r2.z, r2, r2.w
mov_pp r2.x, c10.y
mad_pp r2.x, r2, c6, c6
mul r2.xy, r2.x, r1.zwzw
add_pp r1.w, -r2.z, c10.x
rsq_pp r2.z, r1.w
mov r1.z, c0.x
mul r1.w, c5.x, r1.z
rcp_pp r1.z, r2.z
add_pp r3.xyz, -r1, c10.wwxw
add_pp r2.z, v1, r1.w
mov_pp r2.w, v1
add_pp r2.xy, r2.zwzw, r2
texld r2.xyz, r2, s1
mad_pp r3.xyz, r2, r3, r1
dp3_pp r0.x, r3, r0
mov_pp r0.w, c7.x
mul_pp r1.y, c11.z, r0.w
max_pp r1.x, r0, c10.w
pow r0, r1.x, r1.y
mov r0.z, r0.x
dp3 r0.y, v3, v3
texld r0.x, v2, s4
add_pp r0.w, -r2.x, c10.x
mul r0.w, r0.x, r0
rsq r0.x, r0.y
mul r0.y, r0.w, c2.x
mul_sat r0.x, r0, v3.z
add r3.w, -r0.x, c10.x
mul r2.w, r0.z, r0.y
pow_pp r1, r3.w, c4.x
mov_pp r1.w, r1.x
add_pp r4.xyz, -c8, r4
mad_pp r1.xyz, r1.w, r4, c8
texld r0, v0, s0
mad_pp r0.xyz, r1, r1.w, r0
dp3_pp r1.w, r3, v4
add_pp r1.xyz, r0, r2
mov_pp r3.xyz, c1
mul_pp r0.xyz, r1, c1
max_pp r1.w, r1, c10
mul_pp r4.xyz, r0, r1.w
texldp r0.x, v6, s5
mul_pp r3.xyz, c2, r3
mul_pp r0.y, r0.x, c11.x
mad r3.xyz, r3, r2.w, r4
mul r3.xyz, r3, r0.y
mad_pp r3.xyz, r1, v5, r3
texld r1.xyz, v1, s3
mov_pp r0.y, c1.w
mul r1.xyz, r1, c3.x
mul_pp r0.y, c2.w, r0
mad r1.xyz, r2, -r1, r1
mul r0.y, r2.w, r0
add_pp oC0.xyz, r3, r1
mad oC0.w, r0.x, r0.y, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Float 1 [_LightAmount]
Float 2 [_AtmosFalloff]
Float 3 [_CloudSpeed]
Float 4 [_CloudHeight]
Vector 5 [_AtmosNear]
Vector 6 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 40 ALU, 5 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.5, 1, 0.41999999, 8 },
		{ 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2, fragment.texcoord[0], texture[0], 2D;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R0.z, R0, c[7];
RCP R0.z, R0.z;
MUL R0.zw, R0.xyxy, R0.z;
MOV R0.y, c[3].x;
MOV R0.x, c[7];
MAD R0.x, -R0, c[4], c[4];
MUL R0.y, R0, c[0].x;
MUL R0.zw, R0.x, R0;
ADD R0.x, fragment.texcoord[1].z, R0.y;
MOV R0.y, fragment.texcoord[1].w;
ADD R0.zw, R0.xyxy, R0;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R1.xyz, R0.zwzw, texture[1], 2D;
RSQ R0.x, R0.x;
MUL_SAT R0.w, R0.x, fragment.texcoord[3].z;
MOV R0.xyz, c[5];
ADD R0.w, -R0, c[7].y;
POW R0.w, R0.w, c[2].x;
ADD R0.xyz, -R0, c[6];
MAD R0.xyz, R0.w, R0, c[5];
MAD R0.xyz, R0, R0.w, R2;
ADD R2.xyz, R0, R1;
TEX R0, fragment.texcoord[4], texture[5], 2D;
MUL R3.xyz, R0.w, R0;
TXP R5.x, fragment.texcoord[5], texture[4], 2D;
MUL R0.xyz, R0, R5.x;
MUL R4.xyz, R0, c[8].x;
MUL R3.xyz, R3, c[7].w;
MIN R4.xyz, R3, R4;
TEX R0.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R0.xyz, R0, c[1].x;
MAD R0.xyz, R1, -R0, R0;
MUL R3.xyz, R3, R5.x;
MAX R1.xyz, R4, R3;
MAD result.color.xyz, R2, R1, R0;
MOV result.color.w, R2;
END
# 40 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Float 1 [_LightAmount]
Float 2 [_AtmosFalloff]
Float 3 [_CloudSpeed]
Float 4 [_CloudHeight]
Vector 5 [_AtmosNear]
Vector 6 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_3_0
; 38 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 1.00000000, 0.41999999, -0.50000000, 8.00000000
def c8, 2.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
texld r2, v0, s0
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v3
add r0.x, r1.z, c7.y
rcp r0.y, r0.x
mul r0.zw, r1.xyxy, r0.y
mov_pp r0.x, c7.z
mad_pp r0.x, r0, c4, c4
mul r1.xy, r0.x, r0.zwzw
dp3 r0.x, v3, v3
rsq r0.z, r0.x
mul_sat r0.z, r0, v3
mov r0.y, c0.x
mul r0.y, c3.x, r0
add_pp r0.x, v1.z, r0.y
mov_pp r0.y, v1.w
add_pp r0.xy, r0, r1
mov_pp r3.xyz, c6
texld r1.xyz, r0, s1
add r1.w, -r0.z, c7.x
pow_pp r0, r1.w, c2.x
mov_pp r0.w, r0.x
add_pp r3.xyz, -c5, r3
mad_pp r0.xyz, r0.w, r3, c5
mad_pp r0.xyz, r0, r0.w, r2
add_pp r2.xyz, r0, r1
texld r0, v4, s5
mul_pp r3.xyz, r0.w, r0
texldp r5.x, v5, s4
mul_pp r0.xyz, r0, r5.x
mul_pp r4.xyz, r0, c8.x
mul_pp r3.xyz, r3, c7.w
min_pp r4.xyz, r3, r4
texld r0.xyz, v1, s3
mul r0.xyz, r0, c1.x
mad r0.xyz, r1, -r0, r0
mul_pp r3.xyz, r3, r5.x
max_pp r1.xyz, r4, r3
mad_pp oC0.xyz, r2, r1, r0
mov_pp oC0.w, r2
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 80 ALU, 8 TEX
PARAM c[13] = { program.local[0..8],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 0.81649655, 0.57735026 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R0.x;
MUL R1.xyz, R1.w, fragment.texcoord[3];
ADD R0.x, R1.z, c[9].z;
RCP R0.z, R0.x;
MUL R1.xy, R1, R0.z;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R0.wyzw, c[9].w, -c[9].x;
MUL R2.xy, R0, R0;
ADD_SAT R0.w, R2.x, R2.y;
ADD R0.w, -R0, c[9].x;
MOV R0.z, c[9].y;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.xy, R0.z, R1;
RSQ R1.z, R0.w;
MOV R0.z, c[4].x;
MUL R0.w, R0.z, c[0].x;
RCP R0.z, R1.z;
ADD R2.x, fragment.texcoord[1].z, R0.w;
MOV R2.y, fragment.texcoord[1].w;
ADD R1.xy, R2, R1;
ADD R2.xyz, -R0, c[10].xxyw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R3.xyz, R1, R2, R0;
TEX R2, fragment.texcoord[4], texture[7], 2D;
MUL R2.xyz, R2.w, R2;
MUL R5.xyz, R2, c[11].w;
DP3_SAT R0.z, R3, c[11];
DP3_SAT R0.y, R3, c[12];
DP3_SAT R0.x, R3, c[10].zxww;
DP3 R0.w, R0, R5;
TEX R2, fragment.texcoord[4], texture[6], 2D;
MUL R0.xyz, R2.w, R2;
MUL R0.xyz, R0, R0.w;
MUL R4.xyz, R0, c[11].w;
TXP R0.x, fragment.texcoord[5], texture[5], 2D;
MUL R2.xyz, R2, R0.x;
MUL R0.yzw, R5.y, c[12].xxyz;
MAD R0.yzw, R5.x, c[10].xzxw, R0;
MAD R0.yzw, R5.z, c[11].xxyz, R0;
DP3 R2.w, R0.yzww, R0.yzww;
MUL R2.xyz, R2, c[9].w;
MUL R5.xyz, R4, R0.x;
MIN R2.xyz, R4, R2;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0.yzww;
MAX R2.xyz, R2, R5;
MAD R5.xyz, fragment.texcoord[3], R1.w, R0;
DP3 R0.z, R5, R5;
ADD R0.y, -R1.x, c[9].x;
TEX R0.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.x, R0, R0.y;
MUL R0.w, R0.x, c[1].x;
MUL R4.xyz, R4, c[1];
RSQ R0.y, R0.z;
MUL R0.xyz, R0.y, R5;
DP3 R0.y, R3, R0;
MOV R0.x, c[12].w;
MUL R0.z, R0.x, c[6].x;
MAX R0.y, R0, c[10].x;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R3.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R4.xyz, R4, R0.w;
POW R0.y, R0.y, R0.z;
RSQ R0.x, R0.x;
MUL_SAT R0.w, R0.x, fragment.texcoord[3].z;
MUL R5.xyz, R4, R0.y;
ADD R0.w, -R0, c[9].x;
MOV R0.xyz, c[7];
POW R1.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[8];
MAD R4.xyz, R1.w, R0, c[7];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R1.w, R0;
ADD R0.xyz, R0, R1;
MUL R3.xyz, R3, c[2].x;
MAD R1.xyz, R1, -R3, R3;
MAD R0.xyz, R0, R2, R5;
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 80 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_ShadowMapTexture] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"ps_3_0
; 77 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c9, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c10, 2.00000000, -1.00000000, 8.00000000, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 0
def c12, -0.40824831, 0.70710677, 0.57735026, 0
def c13, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
dp3_pp r0.x, v3, v3
rsq_pp r1.w, r0.x
mul_pp r1.xyz, r1.w, v3
add r0.x, r1.z, c9.z
rcp r0.z, r0.x
mul r1.xy, r1, r0.z
texld r0.yw, v0.zwzw, s2
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
mul_pp r2.xy, r0, r0
add_pp_sat r0.w, r2.x, r2.y
add_pp r0.w, -r0, c9.x
mov_pp r0.z, c9.y
mad_pp r0.z, r0, c5.x, c5.x
mul r1.xy, r0.z, r1
rsq_pp r1.z, r0.w
mov r0.z, c0.x
mul r0.w, c4.x, r0.z
rcp_pp r0.z, r1.z
add_pp r2.x, v1.z, r0.w
mov_pp r2.y, v1.w
add_pp r1.xy, r2, r1
add_pp r2.xyz, -r0, c9.wwxw
texld r1.xyz, r1, s1
mad_pp r3.xyz, r1, r2, r0
texld r2, v4, s7
mul_pp r2.xyz, r2.w, r2
mul_pp r5.xyz, r2, c10.z
dp3_pp_sat r0.z, r3, c11
dp3_pp_sat r0.y, r3, c12
dp3_pp_sat r0.x, r3, c13
dp3_pp r0.w, r0, r5
texld r2, v4, s6
mul_pp r0.xyz, r2.w, r2
mul_pp r0.xyz, r0, r0.w
mul_pp r4.xyz, r0, c10.z
texldp r0.x, v5, s5
mul_pp r2.xyz, r2, r0.x
mul r0.yzw, r5.y, c12.xxyz
mad r0.yzw, r5.x, c13.xxyz, r0
mad r0.yzw, r5.z, c11.xxyz, r0
dp3 r2.w, r0.yzww, r0.yzww
mul_pp r2.xyz, r2, c10.x
mul_pp r5.xyz, r4, r0.x
min_pp r2.xyz, r4, r2
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0.yzww
max_pp r2.xyz, r2, r5
mad_pp r5.xyz, v3, r1.w, r0
dp3_pp r0.z, r5, r5
add_pp r0.y, -r1.x, c9.x
texld r0.x, v2, s4
mul r0.x, r0, r0.y
mul r0.w, r0.x, c1.x
mul_pp r4.xyz, r4, c1
rsq_pp r0.y, r0.z
mul_pp r0.xyz, r0.y, r5
dp3_pp r0.x, r3, r0
mov_pp r0.y, c6.x
mul_pp r4.xyz, r4, r0.w
mul_pp r3.x, c10.w, r0.y
max_pp r2.w, r0.x, c9
pow r0, r2.w, r3.x
dp3 r1.w, v3, v3
rsq r0.y, r1.w
mul_sat r0.y, r0, v3.z
mov_pp r3.xyz, c8
add r1.w, -r0.y, c9.x
mul r5.xyz, r4, r0.x
pow_pp r0, r1.w, c3.x
mov_pp r1.w, r0.x
add_pp r3.xyz, -c7, r3
mad_pp r4.xyz, r1.w, r3, c7
texld r0, v0, s0
texld r3.xyz, v1, s3
mad_pp r0.xyz, r4, r1.w, r0
add_pp r0.xyz, r0, r1
mul r3.xyz, r3, c2.x
mad r1.xyz, r1, -r3, r3
mad_pp r0.xyz, r0, r2, r5
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 28 to 37
//   d3d9 - ALU: 31 to 40
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_Clouds_ST]
Vector 23 [_Mask_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c23.x
dp3 o4.y, r2, r0
dp3 o4.z, v2, r0
dp3 o4.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o3.y, r1, r2
dp3 o3.z, v2, r1
dp3 o3.x, r1, v1
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  highp float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_22;
  lowp float atten_25;
  atten_25 = texture2D (_LightTexture0, vec2(tmpvar_23)).w;
  lowp vec4 c_26;
  highp float nh_27;
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_19, lightDir_2));
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_19, normalize((lightDir_2 + viewDir_24))));
  nh_27 = tmpvar_29;
  mediump float arg1_30;
  arg1_30 = (tmpvar_4 * 128.0);
  highp float tmpvar_31;
  tmpvar_31 = (pow (nh_27, arg1_30) * tmpvar_20);
  highp vec3 tmpvar_32;
  tmpvar_32 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_28) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_31)) * (atten_25 * 2.0));
  c_26.xyz = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_31) * atten_25));
  c_26.w = tmpvar_33;
  c_1.xyz = c_26.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (normal_19, vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD2);
  highp float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  mediump vec3 viewDir_25;
  viewDir_25 = tmpvar_23;
  lowp float atten_26;
  atten_26 = texture2D (_LightTexture0, vec2(tmpvar_24)).w;
  lowp vec4 c_27;
  highp float nh_28;
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_20, lightDir_2));
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_20, normalize((lightDir_2 + viewDir_25))));
  nh_28 = tmpvar_30;
  mediump float arg1_31;
  arg1_31 = (tmpvar_4 * 128.0);
  highp float tmpvar_32;
  tmpvar_32 = (pow (nh_28, arg1_31) * tmpvar_21);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_29) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_32)) * (atten_26 * 2.0));
  c_27.xyz = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_32) * atten_26));
  c_27.w = tmpvar_34;
  c_1.xyz = c_27.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 396
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 406
#line 434
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 438
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 442
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    #line 446
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 450
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 454
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 396
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 406
#line 434
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 438
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 406
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 410
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 414
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 418
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 422
    o.Alpha = c.w;
}
#line 456
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 458
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Clouds = IN.pack1.xy;
    #line 462
    surfIN.uv_Mask = IN.pack1.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 466
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 470
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    c.w = 0.0;
    #line 474
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
Vector 14 [_Clouds_ST]
Vector 15 [_Mask_ST]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[16] = { { 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.xyz, c[9];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
MAD R0.xyz, R2, c[11].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[10];
DP4 R3.z, R1, c[7];
DP4 R3.x, R1, c[5];
DP4 R3.y, R1, c[6];
DP3 result.texcoord[2].y, R0, R2;
DP3 result.texcoord[3].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[15].xyxy, c[15];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 28 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
Vector 13 [_Clouds_ST]
Vector 14 [_Mask_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1.w, c15.x
mov r1.xyz, c8
dp4 r4.y, c9, r0
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c10.w, -v0
mov r1, c4
dp4 r4.x, c9, r1
dp3 o3.y, r2, r3
dp3 o4.y, r3, r4
dp3 o3.z, v2, r2
dp3 o3.x, r2, v1
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
mad o2.zw, v3.xyxy, c14.xyxy, c14
mad o2.xy, v3, c13, c13.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lightDir_2 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD2);
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_21;
  lowp vec4 c_23;
  highp float nh_24;
  lowp float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_19, lightDir_2));
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, normalize((lightDir_2 + viewDir_22))));
  nh_24 = tmpvar_26;
  mediump float arg1_27;
  arg1_27 = (tmpvar_4 * 128.0);
  highp float tmpvar_28;
  tmpvar_28 = (pow (nh_24, arg1_27) * tmpvar_20);
  highp vec3 tmpvar_29;
  tmpvar_29 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_25) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_28)) * 2.0);
  c_23.xyz = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (tmpvar_7.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_28));
  c_23.w = tmpvar_30;
  c_1.xyz = c_23.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (normal_19, vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lightDir_2 = xlv_TEXCOORD3;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_22;
  lowp vec4 c_24;
  highp float nh_25;
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_20, lightDir_2));
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_20, normalize((lightDir_2 + viewDir_23))));
  nh_25 = tmpvar_27;
  mediump float arg1_28;
  arg1_28 = (tmpvar_4 * 128.0);
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_25, arg1_28) * tmpvar_21);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_26) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_29)) * 2.0);
  c_24.xyz = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_7.w + ((_LightColor0.w * _SpecColor.w) * tmpvar_29));
  c_24.w = tmpvar_31;
  c_1.xyz = c_24.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 431
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 435
#line 452
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 435
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 439
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    #line 443
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 447
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 431
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 435
#line 452
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 452
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 456
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Clouds = IN.pack1.xy;
    surfIN.uv_Mask = IN.pack1.zw;
    surfIN.viewDir = IN.viewDir;
    #line 460
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 464
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    #line 468
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), 1.0);
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_Clouds_ST]
Vector 23 [_Mask_ST]
"3.0-!!ARBvp1.0
# 37 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c23.x
dp4 r0.w, v0, c7
dp3 o4.y, r2, r0
dp3 o4.z, v2, r0
dp3 o4.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o3.y, r1, r2
dp3 o3.z, v2, r1
dp3 o3.x, r1, v1
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  highp vec2 P_23;
  P_23 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  mediump vec3 viewDir_25;
  viewDir_25 = tmpvar_22;
  lowp float atten_26;
  atten_26 = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, P_23).w) * texture2D (_LightTextureB0, vec2(tmpvar_24)).w);
  lowp vec4 c_27;
  highp float nh_28;
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_19, lightDir_2));
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_19, normalize((lightDir_2 + viewDir_25))));
  nh_28 = tmpvar_30;
  mediump float arg1_31;
  arg1_31 = (tmpvar_4 * 128.0);
  highp float tmpvar_32;
  tmpvar_32 = (pow (nh_28, arg1_31) * tmpvar_20);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_29) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_32)) * (atten_26 * 2.0));
  c_27.xyz = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_32) * atten_26));
  c_27.w = tmpvar_34;
  c_1.xyz = c_27.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (normal_19, vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD2);
  highp vec2 P_24;
  P_24 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_25;
  tmpvar_25 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_23;
  lowp float atten_27;
  atten_27 = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, P_24).w) * texture2D (_LightTextureB0, vec2(tmpvar_25)).w);
  lowp vec4 c_28;
  highp float nh_29;
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_20, lightDir_2));
  mediump float tmpvar_31;
  tmpvar_31 = max (0.0, dot (tmpvar_20, normalize((lightDir_2 + viewDir_26))));
  nh_29 = tmpvar_31;
  mediump float arg1_32;
  arg1_32 = (tmpvar_4 * 128.0);
  highp float tmpvar_33;
  tmpvar_33 = (pow (nh_29, arg1_32) * tmpvar_21);
  highp vec3 tmpvar_34;
  tmpvar_34 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_30) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_33)) * (atten_27 * 2.0));
  c_28.xyz = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_33) * atten_27));
  c_28.w = tmpvar_35;
  c_1.xyz = c_28.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 433
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 415
#line 443
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 447
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 447
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 451
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    #line 455
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 459
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 463
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 405
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 433
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 415
#line 443
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 447
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 398
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 394
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 419
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 423
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 427
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 431
    o.Alpha = c.w;
}
#line 465
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 467
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Clouds = IN.pack1.xy;
    #line 471
    surfIN.uv_Mask = IN.pack1.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 475
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 479
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    c.w = 0.0;
    #line 483
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_Clouds_ST]
Vector 23 [_Mask_ST]
"3.0-!!ARBvp1.0
# 36 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c23.x
dp3 o4.y, r2, r0
dp3 o4.z, v2, r0
dp3 o4.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o3.y, r1, r2
dp3 o3.z, v2, r1
dp3 o3.x, r1, v1
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  highp float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  mediump vec3 viewDir_24;
  viewDir_24 = tmpvar_22;
  lowp float atten_25;
  atten_25 = (texture2D (_LightTextureB0, vec2(tmpvar_23)).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w);
  lowp vec4 c_26;
  highp float nh_27;
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_19, lightDir_2));
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_19, normalize((lightDir_2 + viewDir_24))));
  nh_27 = tmpvar_29;
  mediump float arg1_30;
  arg1_30 = (tmpvar_4 * 128.0);
  highp float tmpvar_31;
  tmpvar_31 = (pow (nh_27, arg1_30) * tmpvar_20);
  highp vec3 tmpvar_32;
  tmpvar_32 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_28) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_31)) * (atten_25 * 2.0));
  c_26.xyz = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_31) * atten_25));
  c_26.w = tmpvar_33;
  c_1.xyz = c_26.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (normal_19, vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD2);
  highp float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  mediump vec3 viewDir_25;
  viewDir_25 = tmpvar_23;
  lowp float atten_26;
  atten_26 = (texture2D (_LightTextureB0, vec2(tmpvar_24)).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w);
  lowp vec4 c_27;
  highp float nh_28;
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, dot (tmpvar_20, lightDir_2));
  mediump float tmpvar_30;
  tmpvar_30 = max (0.0, dot (tmpvar_20, normalize((lightDir_2 + viewDir_25))));
  nh_28 = tmpvar_30;
  mediump float arg1_31;
  arg1_31 = (tmpvar_4 * 128.0);
  highp float tmpvar_32;
  tmpvar_32 = (pow (nh_28, arg1_31) * tmpvar_21);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_29) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_32)) * (atten_26 * 2.0));
  c_27.xyz = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_32) * atten_26));
  c_27.w = tmpvar_34;
  c_1.xyz = c_27.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 397
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 425
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 407
#line 435
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 439
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 443
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    #line 447
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 451
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 455
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 397
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 425
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 407
#line 435
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 439
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 411
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 415
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 419
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 423
    o.Alpha = c.w;
}
#line 457
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 459
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Clouds = IN.pack1.xy;
    #line 463
    surfIN.uv_Mask = IN.pack1.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 467
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 471
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    c.w = 0.0;
    #line 475
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
Vector 22 [_Clouds_ST]
Vector 23 [_Mask_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.w, c[0].x;
MOV R0.xyz, c[17];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[19].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[18];
DP3 result.texcoord[2].y, R0, R2;
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].y, R2, R3;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, vertex.attrib[14], R3;
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
Vector 21 [_Clouds_ST]
Vector 22 [_Mask_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1.w, c23.x
mov r1.xyz, c16
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c18.w, -v0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o4.y, r3, r4
dp3 o3.z, v2, r2
dp3 o3.x, r2, v1
dp3 o4.z, v2, r4
dp3 o4.x, v1, r4
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lightDir_2 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD2);
  mediump vec3 viewDir_22;
  viewDir_22 = tmpvar_21;
  lowp float atten_23;
  atten_23 = texture2D (_LightTexture0, xlv_TEXCOORD4).w;
  lowp vec4 c_24;
  highp float nh_25;
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_19, lightDir_2));
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_19, normalize((lightDir_2 + viewDir_22))));
  nh_25 = tmpvar_27;
  mediump float arg1_28;
  arg1_28 = (tmpvar_4 * 128.0);
  highp float tmpvar_29;
  tmpvar_29 = (pow (nh_25, arg1_28) * tmpvar_20);
  highp vec3 tmpvar_30;
  tmpvar_30 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_26) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_29)) * (atten_23 * 2.0));
  c_24.xyz = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_29) * atten_23));
  c_24.w = tmpvar_31;
  c_1.xyz = c_24.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD2).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD2;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (normal_19, vec3(0.0, 0.0, 1.0), tmpvar_17.xyz);
  tmpvar_4 = _Shininess;
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD1.zw) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lightDir_2 = xlv_TEXCOORD3;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  mediump vec3 viewDir_23;
  viewDir_23 = tmpvar_22;
  lowp float atten_24;
  atten_24 = texture2D (_LightTexture0, xlv_TEXCOORD4).w;
  lowp vec4 c_25;
  highp float nh_26;
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_20, lightDir_2));
  mediump float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_20, normalize((lightDir_2 + viewDir_23))));
  nh_26 = tmpvar_28;
  mediump float arg1_29;
  arg1_29 = (tmpvar_4 * 128.0);
  highp float tmpvar_30;
  tmpvar_30 = (pow (nh_26, arg1_29) * tmpvar_21);
  highp vec3 tmpvar_31;
  tmpvar_31 = ((((tmpvar_18 * _LightColor0.xyz) * tmpvar_27) + ((_LightColor0.xyz * _SpecColor.xyz) * tmpvar_30)) * (atten_24 * 2.0));
  c_25.xyz = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_7.w + (((_LightColor0.w * _SpecColor.w) * tmpvar_30) * atten_24));
  c_25.w = tmpvar_32;
  c_1.xyz = c_25.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 396
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 406
#line 434
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 438
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 442
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    #line 446
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 450
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 454
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD3 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD4 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 396
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 406
#line 434
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 438
#line 360
lowp vec4 LightingBlinnPhong( in SurfaceOutput s, in lowp vec3 lightDir, in mediump vec3 viewDir, in lowp float atten ) {
    mediump vec3 h = normalize((lightDir + viewDir));
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    #line 364
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = (pow( nh, (s.Specular * 128.0)) * s.Gloss);
    lowp vec4 c;
    c.xyz = ((((s.Albedo * _LightColor0.xyz) * diff) + ((_LightColor0.xyz * _SpecColor.xyz) * spec)) * (atten * 2.0));
    #line 368
    c.w = (s.Alpha + (((_LightColor0.w * _SpecColor.w) * spec) * atten));
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 406
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 410
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 414
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 418
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 422
    o.Alpha = c.w;
}
#line 456
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 458
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Clouds = IN.pack1.xy;
    #line 462
    surfIN.uv_Mask = IN.pack1.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 466
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 470
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingBlinnPhong( o, lightDir, normalize(IN.viewDir), (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    c.w = 0.0;
    #line 474
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD2);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD3);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 59 to 70, TEX: 4 to 6
//   d3d9 - ALU: 61 to 70, TEX: 4 to 6
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 64 ALU, 5 TEX
PARAM c[11] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.x;
MUL R2.xyz, R0.y, fragment.texcoord[3];
MAD R0.xyz, R0.w, fragment.texcoord[2], R2;
DP3 R1.w, R0, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
ADD R0.w, R1.z, c[9].z;
RCP R1.z, R0.w;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R0;
MUL R1.xy, R1, R1.z;
MOV R0.zw, c[10].xyxz;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R3.wyzw, c[9].w, -R0.z;
MUL R1.zw, R0.xyxy, R0.xyxy;
MOV R0.z, c[9].y;
ADD_SAT R2.w, R1.z, R1;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.zw, R0.z, R1.xyxy;
ADD R1.x, -R2.w, c[10];
RSQ R1.y, R1.x;
MOV R0.z, c[4].x;
MUL R1.x, R0.z, c[0];
RCP R0.z, R1.y;
ADD R3.xyz, -R0, c[10].yyxw;
ADD R1.x, fragment.texcoord[1], R1;
MOV R1.y, fragment.texcoord[1];
ADD R1.xy, R1, R1.zwzw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R3.xyz, R1, R3, R0;
DP3 R0.x, R3, R4;
MAX R0.y, R0.x, c[9].x;
MOV R4.xyz, c[7];
ADD R1.w, -R1.x, c[10].x;
MUL R0.z, R0.w, c[6].x;
TEX R0.x, fragment.texcoord[1].zwzw, texture[4], 2D;
MUL R0.w, R0.x, R1;
POW R0.x, R0.y, R0.z;
MUL R0.y, R0.w, c[2].x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.z;
MUL R1.w, R0.x, R0.y;
MUL_SAT R0.w, R0, fragment.texcoord[2].z;
ADD R0.w, -R0, c[10].x;
POW R0.w, R0.w, c[3].x;
ADD R4.xyz, -R4, c[8];
MAD R4.xyz, R0.w, R4, c[7];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R0.w, R0;
ADD R0.xyz, R1, R0;
DP3 R0.w, R3, R2;
MOV R1.xyz, c[2];
MAX R0.w, R0, c[9].x;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R0.w;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, R0.w, texture[5], 2D;
MUL R1.xyz, R1, c[1];
MUL R0.w, R0, c[9];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 64 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
"ps_3_0
; 65 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s4
dcl_2d s5
def c9, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.y, r0.x
dp3_pp r0.x, v2, v2
rsq_pp r0.w, r0.x
mul_pp r3.xyz, r0.y, v3
mad_pp r0.xyz, r0.w, v2, r3
mul_pp r1.xyz, r0.w, v2
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
texld r2.yw, v0.zwzw, s2
add r1.z, r1, c9.y
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mad_pp r2.xy, r2.wyzw, c9.z, c9.w
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.w, r1.z, r1
mov_pp r2.z, c9.x
mad_pp r1.z, r2, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r2.w, c10.x
rsq_pp r1.y, r1.y
rcp_pp r2.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r4.xyz, -r2, c10.yyxw
mul_pp r2.w, c10.z, r0
add_pp r1.x, v1, r1
mov_pp r1.y, v1
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r4, r2
dp3_pp r0.x, r2, r0
max_pp r1.w, r0.x, c10.y
pow r0, r1.w, r2.w
mov_pp r4.xyz, c8
mov r1.w, r0.x
dp3 r0.y, v2, v2
rsq r0.x, r0.y
mul_sat r0.z, r0.x, v2
add_pp r0.y, -r1.x, c10.x
texld r0.x, v1.zwzw, s4
mul r0.x, r0, r0.y
mul r2.w, r0.x, c2.x
add r3.w, -r0.z, c10.x
pow_pp r0, r3.w, c3.x
mul r0.w, r1, r2
mov_pp r1.w, r0.x
add_pp r4.xyz, -c7, r4
mad_pp r4.xyz, r1.w, r4, c7
texld r0.xyz, v0, s0
mad_pp r0.xyz, r4, r1.w, r0
dp3_pp r1.w, r2, r3
add_pp r0.xyz, r1, r0
mov_pp r2.xyz, c1
mul_pp r0.xyz, r0, c1
max_pp r1.x, r1.w, c10.y
mul_pp r1.xyz, r0, r1.x
dp3 r0.x, v4, v4
texld r0.x, r0.x, s5
mul_pp r1.w, r0.x, c9.z
mul_pp r2.xyz, c2, r2
mad r0.xyz, r2, r0.w, r1
mul oC0.xyz, r0, r1.w
mov_pp oC0.w, c10.y
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
"3.0-!!ARBfp1.0
# 59 ALU, 4 TEX
PARAM c[11] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MOV R1.xyz, fragment.texcoord[3];
MAD R1.xyz, R0.x, fragment.texcoord[2], R1;
DP3 R0.w, R1, R1;
MUL R0.xyz, R0.x, fragment.texcoord[2];
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R1;
ADD R0.z, R0, c[9];
RCP R1.z, R0.z;
MOV R0.zw, c[10].xyxz;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R1.xy, R1.wyzw, c[9].w, -R0.z;
MUL R0.xy, R0, R1.z;
MUL R1.zw, R1.xyxy, R1.xyxy;
MOV R0.z, c[9].y;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R2.xy, R0.z, R0;
ADD_SAT R1.z, R1, R1.w;
ADD R0.y, -R1.z, c[10].x;
RSQ R0.y, R0.y;
RCP R1.z, R0.y;
MOV R0.x, c[4];
MUL R0.x, R0, c[0];
ADD R0.x, fragment.texcoord[1], R0;
MOV R0.y, fragment.texcoord[1];
ADD R0.xy, R0, R2;
ADD R2.xyz, -R1, c[10].yyxw;
TEX R0.xyz, R0, texture[1], 2D;
MAD R1.xyz, R0, R2, R1;
DP3 R1.w, R1, R3;
MOV R3.xyz, c[7];
ADD R2.y, -R0.x, c[10].x;
TEX R2.x, fragment.texcoord[1].zwzw, texture[4], 2D;
MUL R2.x, R2, R2.y;
MAX R1.w, R1, c[9].x;
MUL R0.w, R0, c[6].x;
POW R0.w, R1.w, R0.w;
MUL R1.w, R2.x, c[2].x;
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.w, R0, R1;
RSQ R1.w, R2.x;
MUL_SAT R1.w, R1, fragment.texcoord[2].z;
ADD R1.w, -R1, c[10].x;
POW R1.w, R1.w, c[3].x;
ADD R3.xyz, -R3, c[8];
MAD R3.xyz, R1.w, R3, c[7];
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R2.xyz, R3, R1.w, R2;
DP3 R1.x, R1, fragment.texcoord[3];
MAX R1.w, R1.x, c[9].x;
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[1];
MOV R1.xyz, c[2];
MUL R0.xyz, R0, R1.w;
MUL R1.xyz, R1, c[1];
MAD R0.xyz, R1, R0.w, R0;
MUL result.color.xyz, R0, c[9].w;
MOV result.color.w, c[9].x;
END
# 59 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
"ps_3_0
; 61 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s4
def c9, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dp3_pp r0.x, v2, v2
texld r2.yw, v0.zwzw, s2
mad_pp r2.xy, r2.wyzw, c9.z, c9.w
rsq_pp r0.w, r0.x
mov_pp r1.xyz, v3
mad_pp r0.xyz, r0.w, v2, r1
mul_pp r1.xyz, r0.w, v2
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
add r1.z, r1, c9.y
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.w, r1.z, r1
mov_pp r2.z, c9.x
mad_pp r1.z, r2, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r2.w, c10.x
rsq_pp r1.y, r1.y
rcp_pp r2.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r3.xyz, -r2, c10.yyxw
mul_pp r2.w, c10.z, r0
add_pp r1.x, v1, r1
mov_pp r1.y, v1
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r3, r2
dp3_pp r0.x, r2, r0
max_pp r1.w, r0.x, c10.y
pow r0, r1.w, r2.w
mov r1.w, r0.x
dp3 r0.y, v2, v2
rsq r0.x, r0.y
mul_sat r0.z, r0.x, v2
add_pp r0.y, -r1.x, c10.x
texld r0.x, v1.zwzw, s4
mul r0.x, r0, r0.y
add r3.x, -r0.z, c10
mul r2.w, r0.x, c2.x
pow_pp r0, r3.x, c3.x
mul r0.w, r1, r2
mov_pp r1.w, r0.x
mov_pp r3.xyz, c8
add_pp r3.xyz, -c7, r3
mad_pp r3.xyz, r1.w, r3, c7
texld r0.xyz, v0, s0
mad_pp r0.xyz, r3, r1.w, r0
add_pp r0.xyz, r1, r0
dp3_pp r1.w, r2, v3
mov_pp r1.xyz, c1
max_pp r1.w, r1, c10.y
mul_pp r0.xyz, r0, c1
mul_pp r0.xyz, r0, r1.w
mul_pp r1.xyz, c2, r1
mad r0.xyz, r1, r0.w, r0
mul oC0.xyz, r0, c9.z
mov_pp oC0.w, c10.y
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
SetTexture 6 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 70 ALU, 6 TEX
PARAM c[11] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.x;
MUL R2.xyz, R0.y, fragment.texcoord[3];
MAD R0.xyz, R0.w, fragment.texcoord[2], R2;
DP3 R1.w, R0, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
ADD R0.w, R1.z, c[9].z;
RCP R1.z, R0.w;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R0;
MUL R1.xy, R1, R1.z;
MOV R0.zw, c[10].xyxz;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R3.wyzw, c[9].w, -R0.z;
MUL R1.zw, R0.xyxy, R0.xyxy;
MOV R0.z, c[9].y;
ADD_SAT R2.w, R1.z, R1;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.zw, R0.z, R1.xyxy;
ADD R1.x, -R2.w, c[10];
RSQ R1.y, R1.x;
MOV R0.z, c[4].x;
MUL R1.x, R0.z, c[0];
RCP R0.z, R1.y;
ADD R3.xyz, -R0, c[10].yyxw;
ADD R1.x, fragment.texcoord[1], R1;
MOV R1.y, fragment.texcoord[1];
ADD R1.xy, R1, R1.zwzw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R3.xyz, R1, R3, R0;
DP3 R0.x, R3, R4;
MAX R0.y, R0.x, c[9].x;
MOV R4.xyz, c[7];
ADD R1.w, -R1.x, c[10].x;
MUL R0.z, R0.w, c[6].x;
TEX R0.x, fragment.texcoord[1].zwzw, texture[4], 2D;
MUL R0.w, R0.x, R1;
POW R0.x, R0.y, R0.z;
MUL R0.y, R0.w, c[2].x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.z;
MUL R2.w, R0.x, R0.y;
MUL_SAT R0.w, R0, fragment.texcoord[2].z;
ADD R0.w, -R0, c[10].x;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
POW R0.w, R0.w, c[3].x;
ADD R4.xyz, -R4, c[8];
MAD R4.xyz, R0.w, R4, c[7];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R0.w, R0;
ADD R0.xyz, R1, R0;
DP3 R0.w, R3, R2;
MOV R1.xyz, c[2];
MAX R0.w, R0, c[9].x;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R0.w;
RCP R0.w, fragment.texcoord[4].w;
MAD R2.xy, fragment.texcoord[4], R0.w, c[9].y;
TEX R0.w, R2, texture[5], 2D;
SLT R2.x, c[9], fragment.texcoord[4].z;
MUL R1.xyz, R1, c[1];
TEX R1.w, R1.w, texture[6], 2D;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.w, R0, c[9];
MAD R0.xyz, R1, R2.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 70 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
SetTexture 6 [_LightTextureB0] 2D
"ps_3_0
; 70 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c9, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.00000000, 128.00000000, 0.50000000
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dp3_pp r0.x, v3, v3
rsq_pp r0.y, r0.x
dp3_pp r0.x, v2, v2
rsq_pp r0.w, r0.x
mul_pp r3.xyz, r0.y, v3
mad_pp r0.xyz, r0.w, v2, r3
mul_pp r1.xyz, r0.w, v2
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
texld r2.yw, v0.zwzw, s2
add r1.z, r1, c9.y
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mad_pp r2.xy, r2.wyzw, c9.z, c9.w
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.w, r1.z, r1
mov_pp r2.z, c9.x
mad_pp r1.z, r2, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r2.w, c10.x
rsq_pp r1.y, r1.y
rcp_pp r2.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r4.xyz, -r2, c10.yyxw
mul_pp r2.w, c10.z, r0
add_pp r1.x, v1, r1
mov_pp r1.y, v1
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r4, r2
dp3_pp r0.x, r2, r0
max_pp r1.w, r0.x, c10.y
pow r0, r1.w, r2.w
mov_pp r4.xyz, c8
dp3 r0.y, v2, v2
mov r1.w, r0.x
rsq r0.x, r0.y
mul_sat r0.z, r0.x, v2
add_pp r0.y, -r1.x, c10.x
texld r0.x, v1.zwzw, s4
mul r0.x, r0, r0.y
mul r2.w, r0.x, c2.x
add r3.w, -r0.z, c10.x
pow_pp r0, r3.w, c3.x
mov_pp r0.w, r0.x
add_pp r4.xyz, -c7, r4
mad_pp r4.xyz, r0.w, r4, c7
texld r0.xyz, v0, s0
mad_pp r0.xyz, r4, r0.w, r0
add_pp r0.xyz, r1, r0
dp3_pp r0.w, r2, r3
mul_pp r0.xyz, r0, c1
max_pp r0.w, r0, c10.y
mul_pp r2.xyz, r0, r0.w
rcp r0.x, v4.w
mad r3.xy, v4, r0.x, c10.w
dp3 r0.x, v4, v4
texld r0.w, r3, s5
cmp r0.y, -v4.z, c10, c10.x
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s6
mul_pp r0.w, r0.y, r0.x
mov_pp r1.xyz, c1
mul r1.w, r1, r2
mul_pp r0.xyz, c2, r1
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r1.w, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.y
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTextureB0] 2D
SetTexture 6 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 66 ALU, 6 TEX
PARAM c[11] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.x;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.x;
MUL R2.xyz, R0.y, fragment.texcoord[3];
MAD R0.xyz, R0.w, fragment.texcoord[2], R2;
DP3 R1.w, R0, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
ADD R0.w, R1.z, c[9].z;
RCP R1.z, R0.w;
RSQ R1.w, R1.w;
MUL R4.xyz, R1.w, R0;
MUL R1.xy, R1, R1.z;
MOV R0.zw, c[10].xyxz;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R3.wyzw, c[9].w, -R0.z;
MUL R1.zw, R0.xyxy, R0.xyxy;
MOV R0.z, c[9].y;
ADD_SAT R2.w, R1.z, R1;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.zw, R0.z, R1.xyxy;
ADD R1.x, -R2.w, c[10];
RSQ R1.y, R1.x;
MOV R0.z, c[4].x;
MUL R1.x, R0.z, c[0];
RCP R0.z, R1.y;
ADD R3.xyz, -R0, c[10].yyxw;
ADD R1.x, fragment.texcoord[1], R1;
MOV R1.y, fragment.texcoord[1];
ADD R1.xy, R1, R1.zwzw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R3.xyz, R1, R3, R0;
DP3 R0.x, R3, R4;
MAX R0.y, R0.x, c[9].x;
MOV R4.xyz, c[7];
ADD R1.w, -R1.x, c[10].x;
MUL R0.z, R0.w, c[6].x;
TEX R0.x, fragment.texcoord[1].zwzw, texture[4], 2D;
MUL R0.w, R0.x, R1;
POW R0.x, R0.y, R0.z;
MUL R0.y, R0.w, c[2].x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.z;
MUL R1.w, R0.x, R0.y;
MUL_SAT R0.w, R0, fragment.texcoord[2].z;
ADD R0.w, -R0, c[10].x;
POW R0.w, R0.w, c[3].x;
ADD R4.xyz, -R4, c[8];
MAD R4.xyz, R0.w, R4, c[7];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R0.w, R0;
DP3 R0.w, R3, R2;
ADD R0.xyz, R1, R0;
MOV R1.xyz, c[2];
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
MAX R0.w, R0, c[9].x;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R0.w;
MUL R1.xyz, R1, c[1];
TEX R0.w, fragment.texcoord[4], texture[6], CUBE;
TEX R2.w, R2.x, texture[5], 2D;
MUL R0.w, R2, R0;
MUL R0.w, R0, c[9];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 66 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTextureB0] 2D
SetTexture 6 [_LightTexture0] CUBE
"ps_3_0
; 66 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s4
dcl_2d s5
dcl_cube s6
def c9, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.y, r0.x
dp3_pp r0.x, v2, v2
rsq_pp r0.w, r0.x
mul_pp r3.xyz, r0.y, v3
mad_pp r0.xyz, r0.w, v2, r3
mul_pp r1.xyz, r0.w, v2
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
texld r2.yw, v0.zwzw, s2
add r1.z, r1, c9.y
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mad_pp r2.xy, r2.wyzw, c9.z, c9.w
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.w, r1.z, r1
mov_pp r2.z, c9.x
mad_pp r1.z, r2, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r2.w, c10.x
rsq_pp r1.y, r1.y
rcp_pp r2.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r4.xyz, -r2, c10.yyxw
mul_pp r2.w, c10.z, r0
add_pp r1.x, v1, r1
mov_pp r1.y, v1
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r4, r2
dp3_pp r0.x, r2, r0
max_pp r1.w, r0.x, c10.y
pow r0, r1.w, r2.w
mov_pp r4.xyz, c8
dp3 r0.y, v2, v2
mov r1.w, r0.x
rsq r0.x, r0.y
mul_sat r0.z, r0.x, v2
add_pp r0.y, -r1.x, c10.x
texld r0.x, v1.zwzw, s4
mul r0.x, r0, r0.y
mul r2.w, r0.x, c2.x
add r3.w, -r0.z, c10.x
pow_pp r0, r3.w, c3.x
mov_pp r0.w, r0.x
add_pp r4.xyz, -c7, r4
mad_pp r4.xyz, r0.w, r4, c7
texld r0.xyz, v0, s0
mad_pp r0.xyz, r4, r0.w, r0
add_pp r0.xyz, r1, r0
dp3_pp r0.w, r2, r3
mul_pp r0.xyz, r0, c1
max_pp r0.w, r0, c10.y
mul_pp r2.xyz, r0, r0.w
dp3 r0.x, v4, v4
texld r0.x, r0.x, s5
texld r0.w, v4, s6
mul r0.w, r0.x, r0
mov_pp r1.xyz, c1
mul r1.w, r1, r2
mul_pp r0.xyz, c2, r1
mul_pp r0.w, r0, c9.z
mad r0.xyz, r0, r1.w, r2
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.y
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 61 ALU, 5 TEX
PARAM c[11] = { program.local[0..8],
		{ 0, 0.5, 0.41999999, 2 },
		{ 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.x;
MOV R1.xyz, fragment.texcoord[3];
MAD R0.xyz, R0.w, fragment.texcoord[2], R1;
DP3 R1.w, R0, R0;
MUL R1.xyz, R0.w, fragment.texcoord[2];
ADD R0.w, R1.z, c[9].z;
RCP R1.z, R0.w;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R0;
MUL R1.xy, R1, R1.z;
MOV R0.zw, c[10].xyxz;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R2.wyzw, c[9].w, -R0.z;
MUL R1.zw, R0.xyxy, R0.xyxy;
MOV R0.z, c[9].y;
ADD_SAT R2.x, R1.z, R1.w;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.zw, R0.z, R1.xyxy;
ADD R1.x, -R2, c[10];
RSQ R1.y, R1.x;
MOV R0.z, c[4].x;
MUL R1.x, R0.z, c[0];
RCP R0.z, R1.y;
ADD R2.xyz, -R0, c[10].yyxw;
ADD R1.x, fragment.texcoord[1], R1;
MOV R1.y, fragment.texcoord[1];
ADD R1.xy, R1, R1.zwzw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R2.xyz, R1, R2, R0;
DP3 R0.x, R2, R3;
MAX R0.y, R0.x, c[9].x;
MOV R3.xyz, c[7];
ADD R1.w, -R1.x, c[10].x;
MUL R0.z, R0.w, c[6].x;
TEX R0.x, fragment.texcoord[1].zwzw, texture[4], 2D;
MUL R0.w, R0.x, R1;
POW R0.x, R0.y, R0.z;
MUL R0.y, R0.w, c[2].x;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R0.z;
MUL R1.w, R0.x, R0.y;
MUL_SAT R0.w, R0, fragment.texcoord[2].z;
ADD R0.w, -R0, c[10].x;
POW R0.w, R0.w, c[3].x;
ADD R3.xyz, -R3, c[8];
MAD R3.xyz, R0.w, R3, c[7];
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R3, R0.w, R0;
ADD R0.xyz, R1, R0;
DP3 R0.w, R2, fragment.texcoord[3];
MOV R1.xyz, c[2];
MAX R0.w, R0, c[9].x;
MUL R0.xyz, R0, c[1];
MUL R0.xyz, R0, R0.w;
TEX R0.w, fragment.texcoord[4], texture[5], 2D;
MUL R1.xyz, R1, c[1];
MUL R0.w, R0, c[9];
MAD R0.xyz, R1, R1.w, R0;
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 61 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightTexture0] 2D
"ps_3_0
; 62 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s4
dcl_2d s5
def c9, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c10, 1.00000000, 0.00000000, 128.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dp3_pp r0.x, v2, v2
texld r2.yw, v0.zwzw, s2
mad_pp r2.xy, r2.wyzw, c9.z, c9.w
rsq_pp r0.w, r0.x
mov_pp r1.xyz, v3
mad_pp r0.xyz, r0.w, v2, r1
mul_pp r1.xyz, r0.w, v2
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
add r1.z, r1, c9.y
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mul_pp r1.zw, r2.xyxy, r2.xyxy
add_pp_sat r2.w, r1.z, r1
mov_pp r2.z, c9.x
mad_pp r1.z, r2, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r2.w, c10.x
rsq_pp r1.y, r1.y
rcp_pp r2.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r3.xyz, -r2, c10.yyxw
mul_pp r2.w, c10.z, r0
add_pp r1.x, v1, r1
mov_pp r1.y, v1
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r3, r2
dp3_pp r0.x, r2, r0
max_pp r1.w, r0.x, c10.y
pow r0, r1.w, r2.w
dp3 r0.y, v2, v2
mov r1.w, r0.x
rsq r0.x, r0.y
mul_sat r0.z, r0.x, v2
add_pp r0.y, -r1.x, c10.x
texld r0.x, v1.zwzw, s4
mul r0.x, r0, r0.y
mul r2.w, r0.x, c2.x
add r3.x, -r0.z, c10
pow_pp r0, r3.x, c3.x
mov_pp r0.w, r0.x
mov_pp r3.xyz, c8
add_pp r3.xyz, -c7, r3
mad_pp r3.xyz, r0.w, r3, c7
texld r0.xyz, v0, s0
mad_pp r0.xyz, r3, r0.w, r0
add_pp r0.xyz, r1, r0
dp3_pp r0.w, r2, v3
mov_pp r1.xyz, c1
max_pp r0.w, r0, c10.y
mul_pp r0.xyz, r0, c1
mul_pp r0.xyz, r0, r0.w
texld r0.w, v4, s5
mul r1.w, r1, r2
mul_pp r1.xyz, c2, r1
mul_pp r0.w, r0, c9.z
mad r0.xyz, r1, r1.w, r0
mul oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.y
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 31 to 31
//   d3d9 - ALU: 32 to 32
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
Vector 15 [_BumpMap_ST]
Vector 16 [_Clouds_ST]
"3.0-!!ARBvp1.0
# 31 ALU
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2].xyz, R0, c[14].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3].xyz, R0, c[14].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[4].xyz, R0, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 31 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_BumpMap_ST]
Vector 15 [_Clouds_ST]
"vs_3_0
; 32 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3.xyz, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4.xyz, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5.xyz, r0, c13.w
mad o1.zw, v3.xyxy, c15.xyxy, c15
mad o1.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  vec3 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  vec3 v_8;
  v_8.x = _Object2World[0].y;
  v_8.y = _Object2World[1].y;
  v_8.z = _Object2World[2].y;
  vec3 v_9;
  v_9.x = _Object2World[0].z;
  v_9.y = _Object2World[1].z;
  v_9.z = _Object2World[2].z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((tmpvar_6 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_6 * v_8) * unity_Scale.w);
  xlv_TEXCOORD4 = ((tmpvar_6 * v_9) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_6;
  tmpvar_6 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_6;
  mediump float height_7;
  height_7 = _CloudHeight;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = (height_7 - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  highp vec2 tmpvar_12;
  tmpvar_12 = (cloudUV_5 + (tmpvar_10 * (v_9.xy / v_9.z)));
  cloudUV_5 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.xy).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), texture2D (_Clouds, cloudUV_5).xyz);
  tmpvar_4 = _Shininess;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD2, tmpvar_13);
  worldN_2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3, tmpvar_13);
  worldN_2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, tmpvar_13);
  worldN_2.z = tmpvar_16;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = tmpvar_4;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  vec3 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  vec3 v_8;
  v_8.x = _Object2World[0].y;
  v_8.y = _Object2World[1].y;
  v_8.z = _Object2World[2].y;
  vec3 v_9;
  v_9.x = _Object2World[0].z;
  v_9.y = _Object2World[1].z;
  v_9.z = _Object2World[2].z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((tmpvar_6 * v_7) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_6 * v_8) * unity_Scale.w);
  xlv_TEXCOORD4 = ((tmpvar_6 * v_9) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform sampler2D _Clouds;
uniform sampler2D _BumpMap;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  mediump float tmpvar_4;
  mediump vec2 cloudUV_5;
  cloudUV_5 = tmpvar_3;
  highp float tmpvar_6;
  tmpvar_6 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_6;
  mediump float height_7;
  height_7 = _CloudHeight;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = (height_7 - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  highp vec2 tmpvar_12;
  tmpvar_12 = (cloudUV_5 + (tmpvar_10 * (v_9.xy / v_9.z)));
  cloudUV_5 = tmpvar_12;
  lowp vec3 normal_13;
  normal_13.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.xy).wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_14;
  tmpvar_14 = mix (normal_13, vec3(0.0, 0.0, 1.0), texture2D (_Clouds, cloudUV_5).xyz);
  tmpvar_4 = _Shininess;
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD2, tmpvar_14);
  worldN_2.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD3, tmpvar_14);
  worldN_2.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (xlv_TEXCOORD4, tmpvar_14);
  worldN_2.z = tmpvar_17;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = tmpvar_4;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
#line 448
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 434
v2f_surf vert_surf( in appdata_full v ) {
    #line 436
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    #line 440
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.TtoW0 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 0).xyz) * unity_Scale.w);
    o.TtoW1 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 1).xyz) * unity_Scale.w);
    #line 444
    o.TtoW2 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 2).xyz) * unity_Scale.w);
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec3(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec3(xl_retval.TtoW2);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 432
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Clouds_ST;
#line 448
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 448
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_BumpMap = IN.pack0.xy;
    #line 452
    surfIN.uv_Clouds = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 456
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 460
    surf( surfIN, o);
    lowp vec3 worldN;
    worldN.x = dot( IN.TtoW0, o.Normal);
    worldN.y = dot( IN.TtoW1, o.Normal);
    #line 464
    worldN.z = dot( IN.TtoW2, o.Normal);
    o.Normal = worldN;
    lowp vec4 res;
    res.xyz = ((o.Normal * 0.5) + 0.5);
    #line 468
    res.w = o.Specular;
    return res;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec3(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec3(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 29 to 29, TEX: 2 to 2
//   d3d9 - ALU: 27 to 27, TEX: 2 to 2
SubProgram "opengl " {
Keywords { }
Vector 0 [_Time]
Float 1 [_CloudSpeed]
Float 2 [_CloudHeight]
Float 3 [_Shininess]
SetTexture 0 [_Clouds] 2D
SetTexture 1 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 29 ALU, 2 TEX
PARAM c[6] = { program.local[0..3],
		{ 0.5, 0.41999999, 2, 1 },
		{ 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
MAD R1.xy, R0.wyzw, c[4].z, -c[4].w;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R0.w, R1.z, R1;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.x, R2.z, c[4].y;
RCP R0.x, R0.x;
MOV R0.z, c[4].x;
ADD R0.w, -R0, c[4];
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
MUL R0.xy, R2, R0.x;
MAD R0.z, -R0, c[2].x, c[2].x;
MUL R0.xy, R0.z, R0;
MOV R0.z, c[1].x;
MUL R0.z, R0, c[0].x;
ADD R0.z, fragment.texcoord[0], R0;
MOV R0.w, fragment.texcoord[0];
ADD R0.xy, R0.zwzw, R0;
TEX R0.xyz, R0, texture[0], 2D;
ADD R2.xyz, -R1, c[5].xxyw;
MAD R1.xyz, R0, R2, R1;
DP3 R0.z, fragment.texcoord[4], R1;
DP3 R0.x, R1, fragment.texcoord[2];
DP3 R0.y, R1, fragment.texcoord[3];
MAD result.color.xyz, R0, c[4].x, c[4].x;
MOV result.color.w, c[3].x;
END
# 29 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_Time]
Float 1 [_CloudSpeed]
Float 2 [_CloudHeight]
Float 3 [_Shininess]
SetTexture 0 [_Clouds] 2D
SetTexture 1 [_BumpMap] 2D
"ps_3_0
; 27 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c4, -0.50000000, 0.41999999, 2.00000000, -1.00000000
def c5, 1.00000000, 0.00000000, 0.50000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0, s1
mad_pp r1.xy, r0.wyzw, c4.z, c4.w
mul_pp r1.zw, r1.xyxy, r1.xyxy
add_pp_sat r0.w, r1.z, r1
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
add r0.x, r2.z, c4.y
rcp r0.x, r0.x
mov_pp r0.z, c4.x
add_pp r0.w, -r0, c5.x
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.w
mul r0.xy, r2, r0.x
mad_pp r0.z, r0, c2.x, c2.x
mul r0.xy, r0.z, r0
mov r0.z, c0.x
mul r0.z, c1.x, r0
add_pp r0.z, v0, r0
mov_pp r0.w, v0
add_pp r0.xy, r0.zwzw, r0
texld r0.xyz, r0, s0
add_pp r2.xyz, -r1, c5.yyxw
mad_pp r1.xyz, r0, r2, r1
dp3 r0.z, v4, r1
dp3 r0.x, r1, v2
dp3 r0.y, r1, v3
mad_pp oC0.xyz, r0, c5.z, c5.z
mov_pp oC0.w, c3.x
"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 6
//   opengl - ALU: 28 to 45
//   d3d9 - ALU: 29 to 46
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_Emission_ST]
Vector 26 [_Clouds_ST]
Vector 27 [_Mask_ST]
"3.0-!!ARBvp1.0
# 45 ALU
PARAM c[28] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[5].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_Emission_ST]
Vector 26 [_Clouds_ST]
Vector 27 [_Mask_ST]
"vs_3_0
; 46 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c28, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c28.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o6.xyz, r2, r3
mov r1.w, c28.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c28.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.zw, v3.xyxy, c26.xyxy, c26
mad o2.xy, v3, c25, c25.zwzw
mad o3.xy, v3, c27, c27.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (tmpvar_10 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
  highp float vC_14;
  mediump vec3 x3_15;
  mediump vec3 x2_16;
  mediump vec3 x1_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAr, normal_13);
  x1_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAg, normal_13);
  x1_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAb, normal_13);
  x1_17.z = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_13.xyzz * normal_13.yzzx);
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBr, tmpvar_21);
  x2_16.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBg, tmpvar_21);
  x2_16.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBb, tmpvar_21);
  x2_16.z = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y));
  vC_14 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (unity_SHC.xyz * vC_14);
  x3_15 = tmpvar_26;
  tmpvar_12 = ((x1_17 + x2_16) + x3_15);
  tmpvar_5 = tmpvar_12;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_27 = tmpvar_1.xyz;
  tmpvar_28 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_27.x;
  tmpvar_29[0].y = tmpvar_28.x;
  tmpvar_29[0].z = tmpvar_2.x;
  tmpvar_29[1].x = tmpvar_27.y;
  tmpvar_29[1].y = tmpvar_28.y;
  tmpvar_29[1].z = tmpvar_2.y;
  tmpvar_29[2].x = tmpvar_27.z;
  tmpvar_29[2].y = tmpvar_28.z;
  tmpvar_29[2].z = tmpvar_2.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_29 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_4;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD3;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_17);
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_23;
  lowp vec4 c_24;
  lowp float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_22.w * tmpvar_20);
  spec_25 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((tmpvar_18 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_25));
  c_24.xyz = tmpvar_27;
  c_24.w = (tmpvar_7.w + (spec_25 * _SpecColor.w));
  c_2 = c_24;
  c_2.xyz = (c_2.xyz + tmpvar_19.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (tmpvar_10 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
  highp float vC_14;
  mediump vec3 x3_15;
  mediump vec3 x2_16;
  mediump vec3 x1_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAr, normal_13);
  x1_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAg, normal_13);
  x1_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAb, normal_13);
  x1_17.z = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_13.xyzz * normal_13.yzzx);
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBr, tmpvar_21);
  x2_16.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBg, tmpvar_21);
  x2_16.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBb, tmpvar_21);
  x2_16.z = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y));
  vC_14 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (unity_SHC.xyz * vC_14);
  x3_15 = tmpvar_26;
  tmpvar_12 = ((x1_17 + x2_16) + x3_15);
  tmpvar_5 = tmpvar_12;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_27 = tmpvar_1.xyz;
  tmpvar_28 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_27.x;
  tmpvar_29[0].y = tmpvar_28.x;
  tmpvar_29[0].z = tmpvar_2.x;
  tmpvar_29[1].x = tmpvar_27.y;
  tmpvar_29[1].y = tmpvar_28.y;
  tmpvar_29[1].z = tmpvar_2.y;
  tmpvar_29[2].x = tmpvar_27.z;
  tmpvar_29[2].y = tmpvar_28.z;
  tmpvar_29[2].z = tmpvar_2.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_29 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_4;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD3;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_20;
  tmpvar_20 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_17);
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_23.w;
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_24;
  lowp vec4 c_25;
  lowp float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_23.w * tmpvar_21);
  spec_26 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((tmpvar_18 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_26));
  c_25.xyz = tmpvar_28;
  c_25.w = (tmpvar_7.w + (spec_26 * _SpecColor.w));
  c_2 = c_25;
  c_2.xyz = (c_2.xyz + tmpvar_20.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 441
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 445
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 449
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 457
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 457
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 461
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 465
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 469
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 473
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    light.xyz += IN.vlight;
    #line 477
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_Emission_ST]
Vector 25 [_Clouds_ST]
Vector 26 [_Mask_ST]
"3.0-!!ARBvp1.0
# 37 ALU
PARAM c[27] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[6].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 37 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_Emission_ST]
Vector 25 [_Clouds_ST]
Vector 26 [_Mask_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c27.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c17.x
mad o5.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c27.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mov o5.zw, r0
mul o7.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_8;
  lowp float fresnel_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = pow (fresnel_9, _AtmosFalloff);
  cloudUV_8 = tmpvar_7;
  highp float tmpvar_13;
  tmpvar_13 = (cloudUV_8.x + (_Time * _CloudSpeed).x);
  cloudUV_8.x = tmpvar_13;
  mediump float height_14;
  height_14 = _CloudHeight;
  mediump vec3 viewDir_15;
  viewDir_15 = xlv_TEXCOORD3;
  highp vec3 v_16;
  mediump float tmpvar_17;
  tmpvar_17 = (height_14 - (height_14 / 2.0));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(viewDir_15);
  v_16 = tmpvar_18;
  v_16.z = (v_16.z + 0.42);
  highp vec2 tmpvar_19;
  tmpvar_19 = (cloudUV_8 + (tmpvar_17 * (v_16.xy / v_16.z)));
  cloudUV_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Clouds, cloudUV_8);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_10.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_12)) * tmpvar_12)) + tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_20);
  lowp float tmpvar_23;
  tmpvar_23 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_20)) * _SpecColor).x;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_6 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_25.w;
  highp float tmpvar_26;
  tmpvar_26 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lmFull_4 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  lmIndirect_3 = tmpvar_28;
  light_6.xyz = (tmpvar_25.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_29;
  lowp float spec_30;
  mediump float tmpvar_31;
  tmpvar_31 = (tmpvar_25.w * tmpvar_23);
  spec_30 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_21 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_30));
  c_29.xyz = tmpvar_32;
  c_29.w = (tmpvar_10.w + (spec_30 * _SpecColor.w));
  c_2 = c_29;
  c_2.xyz = (c_2.xyz + tmpvar_22.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_8;
  lowp float fresnel_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = pow (fresnel_9, _AtmosFalloff);
  cloudUV_8 = tmpvar_7;
  highp float tmpvar_13;
  tmpvar_13 = (cloudUV_8.x + (_Time * _CloudSpeed).x);
  cloudUV_8.x = tmpvar_13;
  mediump float height_14;
  height_14 = _CloudHeight;
  mediump vec3 viewDir_15;
  viewDir_15 = xlv_TEXCOORD3;
  highp vec3 v_16;
  mediump float tmpvar_17;
  tmpvar_17 = (height_14 - (height_14 / 2.0));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(viewDir_15);
  v_16 = tmpvar_18;
  v_16.z = (v_16.z + 0.42);
  highp vec2 tmpvar_19;
  tmpvar_19 = (cloudUV_8 + (tmpvar_17 * (v_16.xy / v_16.z)));
  cloudUV_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Clouds, cloudUV_8);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_10.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_12)) * tmpvar_12)) + tmpvar_20.xyz);
  lowp vec3 normal_22;
  normal_22.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_23;
  tmpvar_23 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_20);
  lowp float tmpvar_24;
  tmpvar_24 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_20)) * _SpecColor).x;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_6 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_26.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp float tmpvar_29;
  tmpvar_29 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_27.w) * tmpvar_27.xyz);
  lmFull_4 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = ((8.0 * tmpvar_28.w) * tmpvar_28.xyz);
  lmIndirect_3 = tmpvar_31;
  light_6.xyz = (tmpvar_26.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_32;
  lowp float spec_33;
  mediump float tmpvar_34;
  tmpvar_34 = (tmpvar_26.w * tmpvar_24);
  spec_33 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = ((tmpvar_21 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_33));
  c_32.xyz = tmpvar_35;
  c_32.w = (tmpvar_10.w + (spec_33 * _SpecColor.w));
  c_2 = c_32;
  c_2.xyz = (c_2.xyz + tmpvar_23.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 434
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 438
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 458
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 462
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 440
v2f_surf vert_surf( in appdata_full v ) {
    #line 442
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 446
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    #line 450
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 454
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 434
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 438
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 458
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 462
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 466
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    #line 470
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 474
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 478
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    #line 482
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    #line 486
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    #line 490
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_Emission_ST]
Vector 16 [_Clouds_ST]
Vector 17 [_Mask_ST]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R2.xyz, R2, c[11].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[10].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 28 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_Emission_ST]
Vector 16 [_Clouds_ST]
Vector 17 [_Mask_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c18.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c11.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c9.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.zw, v3.xyxy, c16.xyxy, c16
mad o2.xy, v3, c15, c15.zwzw
mad o3.xy, v3, c17, c17.zwzw
mad o6.xy, v4, c12, c12.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_5;
  mediump vec2 cloudUV_6;
  lowp float fresnel_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_7 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = pow (fresnel_7, _AtmosFalloff);
  cloudUV_6 = tmpvar_4;
  highp float tmpvar_11;
  tmpvar_11 = (cloudUV_6.x + (_Time * _CloudSpeed).x);
  cloudUV_6.x = tmpvar_11;
  mediump float height_12;
  height_12 = _CloudHeight;
  mediump vec3 viewDir_13;
  viewDir_13 = xlv_TEXCOORD3;
  highp vec3 v_14;
  mediump float tmpvar_15;
  tmpvar_15 = (height_12 - (height_12 / 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(viewDir_13);
  v_14 = tmpvar_16;
  v_14.z = (v_14.z + 0.42);
  highp vec2 tmpvar_17;
  tmpvar_17 = (cloudUV_6 + (tmpvar_15 * (v_14.xy / v_14.z)));
  cloudUV_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Clouds, cloudUV_6);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_8.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_10)) * tmpvar_10)) + tmpvar_18.xyz);
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_18.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_18);
  tmpvar_5 = _Shininess;
  lowp float tmpvar_22;
  tmpvar_22 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_18)) * _SpecColor).x;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_25;
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_24;
  highp float nh_27;
  mat3 tmpvar_28;
  tmpvar_28[0].x = 0.816497;
  tmpvar_28[0].y = -0.408248;
  tmpvar_28[0].z = -0.408248;
  tmpvar_28[1].x = 0.0;
  tmpvar_28[1].y = 0.707107;
  tmpvar_28[1].z = -0.707107;
  tmpvar_28[2].x = 0.57735;
  tmpvar_28[2].y = 0.57735;
  tmpvar_28[2].z = 0.57735;
  mediump vec3 normal_29;
  normal_29 = tmpvar_20;
  mediump vec3 scalePerBasisVector_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  scalePerBasisVector_30 = tmpvar_33;
  lm_31 = (lm_31 * dot (clamp ((tmpvar_28 * normal_29), 0.0, 1.0), scalePerBasisVector_30));
  vec3 v_34;
  v_34.x = tmpvar_28[0].x;
  v_34.y = tmpvar_28[1].x;
  v_34.z = tmpvar_28[2].x;
  vec3 v_35;
  v_35.x = tmpvar_28[0].y;
  v_35.y = tmpvar_28[1].y;
  v_35.z = tmpvar_28[2].y;
  vec3 v_36;
  v_36.x = tmpvar_28[0].z;
  v_36.y = tmpvar_28[1].z;
  v_36.z = tmpvar_28[2].z;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, dot (tmpvar_20, normalize((normalize((((scalePerBasisVector_30.x * v_34) + (scalePerBasisVector_30.y * v_35)) + (scalePerBasisVector_30.z * v_36))) + viewDir_26))));
  nh_27 = tmpvar_37;
  mediump float arg1_38;
  arg1_38 = (tmpvar_5 * 128.0);
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = lm_31;
  tmpvar_39.w = pow (nh_27, arg1_38);
  tmpvar_25 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_25);
  light_3 = tmpvar_40;
  lowp vec4 c_41;
  lowp float spec_42;
  mediump float tmpvar_43;
  tmpvar_43 = (tmpvar_40.w * tmpvar_22);
  spec_42 = tmpvar_43;
  mediump vec3 tmpvar_44;
  tmpvar_44 = ((tmpvar_19 * tmpvar_40.xyz) + ((tmpvar_40.xyz * _SpecColor.xyz) * spec_42));
  c_41.xyz = tmpvar_44;
  c_41.w = (tmpvar_8.w + (spec_42 * _SpecColor.w));
  c_2 = c_41;
  c_2.xyz = (c_2.xyz + tmpvar_21.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_5;
  mediump vec2 cloudUV_6;
  lowp float fresnel_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_7 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = pow (fresnel_7, _AtmosFalloff);
  cloudUV_6 = tmpvar_4;
  highp float tmpvar_11;
  tmpvar_11 = (cloudUV_6.x + (_Time * _CloudSpeed).x);
  cloudUV_6.x = tmpvar_11;
  mediump float height_12;
  height_12 = _CloudHeight;
  mediump vec3 viewDir_13;
  viewDir_13 = xlv_TEXCOORD3;
  highp vec3 v_14;
  mediump float tmpvar_15;
  tmpvar_15 = (height_12 - (height_12 / 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(viewDir_13);
  v_14 = tmpvar_16;
  v_14.z = (v_14.z + 0.42);
  highp vec2 tmpvar_17;
  tmpvar_17 = (cloudUV_6 + (tmpvar_15 * (v_14.xy / v_14.z)));
  cloudUV_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Clouds, cloudUV_6);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_8.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_10)) * tmpvar_10)) + tmpvar_18.xyz);
  lowp vec3 normal_20;
  normal_20.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = mix (normal_20, vec3(0.0, 0.0, 1.0), tmpvar_18.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_18);
  tmpvar_5 = _Shininess;
  lowp float tmpvar_23;
  tmpvar_23 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_18)) * _SpecColor).x;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_28;
  mediump vec3 viewDir_29;
  viewDir_29 = tmpvar_27;
  highp float nh_30;
  mat3 tmpvar_31;
  tmpvar_31[0].x = 0.816497;
  tmpvar_31[0].y = -0.408248;
  tmpvar_31[0].z = -0.408248;
  tmpvar_31[1].x = 0.0;
  tmpvar_31[1].y = 0.707107;
  tmpvar_31[1].z = -0.707107;
  tmpvar_31[2].x = 0.57735;
  tmpvar_31[2].y = 0.57735;
  tmpvar_31[2].z = 0.57735;
  mediump vec3 normal_32;
  normal_32 = tmpvar_21;
  mediump vec3 scalePerBasisVector_33;
  mediump vec3 lm_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = ((8.0 * tmpvar_25.w) * tmpvar_25.xyz);
  lm_34 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = ((8.0 * tmpvar_26.w) * tmpvar_26.xyz);
  scalePerBasisVector_33 = tmpvar_36;
  lm_34 = (lm_34 * dot (clamp ((tmpvar_31 * normal_32), 0.0, 1.0), scalePerBasisVector_33));
  vec3 v_37;
  v_37.x = tmpvar_31[0].x;
  v_37.y = tmpvar_31[1].x;
  v_37.z = tmpvar_31[2].x;
  vec3 v_38;
  v_38.x = tmpvar_31[0].y;
  v_38.y = tmpvar_31[1].y;
  v_38.z = tmpvar_31[2].y;
  vec3 v_39;
  v_39.x = tmpvar_31[0].z;
  v_39.y = tmpvar_31[1].z;
  v_39.z = tmpvar_31[2].z;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, dot (tmpvar_21, normalize((normalize((((scalePerBasisVector_33.x * v_37) + (scalePerBasisVector_33.y * v_38)) + (scalePerBasisVector_33.z * v_39))) + viewDir_29))));
  nh_30 = tmpvar_40;
  mediump float arg1_41;
  arg1_41 = (tmpvar_5 * 128.0);
  highp vec4 tmpvar_42;
  tmpvar_42.xyz = lm_34;
  tmpvar_42.w = pow (nh_30, arg1_41);
  tmpvar_28 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_28);
  light_3 = tmpvar_43;
  lowp vec4 c_44;
  lowp float spec_45;
  mediump float tmpvar_46;
  tmpvar_46 = (tmpvar_43.w * tmpvar_23);
  spec_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = ((tmpvar_19 * tmpvar_43.xyz) + ((tmpvar_43.xyz * _SpecColor.xyz) * spec_45));
  c_44.xyz = tmpvar_47;
  c_44.w = (tmpvar_8.w + (spec_45 * _SpecColor.w));
  c_2 = c_44;
  c_2.xyz = (c_2.xyz + tmpvar_22.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 437
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
#line 457
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    #line 449
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 437
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
#line 457
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 462
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 466
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 470
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 474
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 478
    light = (-log2(light));
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    #line 482
    mediump vec4 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor);
    light += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    #line 486
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_Emission_ST]
Vector 26 [_Clouds_ST]
Vector 27 [_Mask_ST]
"3.0-!!ARBvp1.0
# 45 ALU
PARAM c[28] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[5].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
Vector 25 [_Emission_ST]
Vector 26 [_Clouds_ST]
Vector 27 [_Mask_ST]
"vs_3_0
; 46 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c28, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c28.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o6.xyz, r2, r3
mov r1.w, c28.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c28.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.zw, v3.xyxy, c26.xyxy, c26
mad o2.xy, v3, c25, c25.zwzw
mad o3.xy, v3, c27, c27.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (tmpvar_10 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
  highp float vC_14;
  mediump vec3 x3_15;
  mediump vec3 x2_16;
  mediump vec3 x1_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAr, normal_13);
  x1_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAg, normal_13);
  x1_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAb, normal_13);
  x1_17.z = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_13.xyzz * normal_13.yzzx);
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBr, tmpvar_21);
  x2_16.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBg, tmpvar_21);
  x2_16.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBb, tmpvar_21);
  x2_16.z = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y));
  vC_14 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (unity_SHC.xyz * vC_14);
  x3_15 = tmpvar_26;
  tmpvar_12 = ((x1_17 + x2_16) + x3_15);
  tmpvar_5 = tmpvar_12;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_27 = tmpvar_1.xyz;
  tmpvar_28 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_27.x;
  tmpvar_29[0].y = tmpvar_28.x;
  tmpvar_29[0].z = tmpvar_2.x;
  tmpvar_29[1].x = tmpvar_27.y;
  tmpvar_29[1].y = tmpvar_28.y;
  tmpvar_29[1].z = tmpvar_2.y;
  tmpvar_29[2].x = tmpvar_27.z;
  tmpvar_29[2].y = tmpvar_28.z;
  tmpvar_29[2].z = tmpvar_2.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_29 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_4;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD3;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_17);
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_23;
  lowp vec4 c_24;
  lowp float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = (tmpvar_22.w * tmpvar_20);
  spec_25 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = ((tmpvar_18 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_25));
  c_24.xyz = tmpvar_27;
  c_24.w = (tmpvar_7.w + (spec_25 * _SpecColor.w));
  c_2 = c_24;
  c_2.xyz = (c_2.xyz + tmpvar_19.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (tmpvar_10 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_12;
  mediump vec4 normal_13;
  normal_13 = tmpvar_11;
  highp float vC_14;
  mediump vec3 x3_15;
  mediump vec3 x2_16;
  mediump vec3 x1_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAr, normal_13);
  x1_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAg, normal_13);
  x1_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAb, normal_13);
  x1_17.z = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_13.xyzz * normal_13.yzzx);
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBr, tmpvar_21);
  x2_16.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBg, tmpvar_21);
  x2_16.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBb, tmpvar_21);
  x2_16.z = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y));
  vC_14 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (unity_SHC.xyz * vC_14);
  x3_15 = tmpvar_26;
  tmpvar_12 = ((x1_17 + x2_16) + x3_15);
  tmpvar_5 = tmpvar_12;
  highp vec3 tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_27 = tmpvar_1.xyz;
  tmpvar_28 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_29;
  tmpvar_29[0].x = tmpvar_27.x;
  tmpvar_29[0].y = tmpvar_28.x;
  tmpvar_29[0].z = tmpvar_2.x;
  tmpvar_29[1].x = tmpvar_27.y;
  tmpvar_29[1].y = tmpvar_28.y;
  tmpvar_29[1].z = tmpvar_2.y;
  tmpvar_29[2].x = tmpvar_27.z;
  tmpvar_29[2].y = tmpvar_28.z;
  tmpvar_29[2].z = tmpvar_2.z;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_29 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_5;
  lowp float fresnel_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = pow (fresnel_6, _AtmosFalloff);
  cloudUV_5 = tmpvar_4;
  highp float tmpvar_10;
  tmpvar_10 = (cloudUV_5.x + (_Time * _CloudSpeed).x);
  cloudUV_5.x = tmpvar_10;
  mediump float height_11;
  height_11 = _CloudHeight;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD3;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = (height_11 - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  highp vec2 tmpvar_16;
  tmpvar_16 = (cloudUV_5 + (tmpvar_14 * (v_13.xy / v_13.z)));
  cloudUV_5 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Clouds, cloudUV_5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((tmpvar_7.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_9)) * tmpvar_9)) + tmpvar_17.xyz);
  lowp vec3 normal_19;
  normal_19.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_19.z = sqrt((1.0 - clamp (dot (normal_19.xy, normal_19.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_20;
  tmpvar_20 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_17);
  lowp float tmpvar_21;
  tmpvar_21 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_17)) * _SpecColor).x;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_23.w;
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_23.xyz + xlv_TEXCOORD5);
  light_3.xyz = tmpvar_24;
  lowp vec4 c_25;
  lowp float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_23.w * tmpvar_21);
  spec_26 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = ((tmpvar_18 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_26));
  c_25.xyz = tmpvar_28;
  c_25.w = (tmpvar_7.w + (spec_26 * _SpecColor.w));
  c_2 = c_25;
  c_2.xyz = (c_2.xyz + tmpvar_20.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 457
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 438
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 441
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    #line 445
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 449
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _Clouds_ST;
#line 437
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 457
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 457
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 461
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    #line 465
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 469
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 473
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    #line 477
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.vlight = vec3(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_Emission_ST]
Vector 25 [_Clouds_ST]
Vector 26 [_Mask_ST]
"3.0-!!ARBvp1.0
# 37 ALU
PARAM c[27] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[6].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 37 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
Vector 24 [_Emission_ST]
Vector 25 [_Clouds_ST]
Vector 26 [_Mask_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c27.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c17.x
mad o5.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c27.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mov o5.zw, r0
mul o7.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_8;
  lowp float fresnel_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = pow (fresnel_9, _AtmosFalloff);
  cloudUV_8 = tmpvar_7;
  highp float tmpvar_13;
  tmpvar_13 = (cloudUV_8.x + (_Time * _CloudSpeed).x);
  cloudUV_8.x = tmpvar_13;
  mediump float height_14;
  height_14 = _CloudHeight;
  mediump vec3 viewDir_15;
  viewDir_15 = xlv_TEXCOORD3;
  highp vec3 v_16;
  mediump float tmpvar_17;
  tmpvar_17 = (height_14 - (height_14 / 2.0));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(viewDir_15);
  v_16 = tmpvar_18;
  v_16.z = (v_16.z + 0.42);
  highp vec2 tmpvar_19;
  tmpvar_19 = (cloudUV_8 + (tmpvar_17 * (v_16.xy / v_16.z)));
  cloudUV_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Clouds, cloudUV_8);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_10.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_12)) * tmpvar_12)) + tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_20);
  lowp float tmpvar_23;
  tmpvar_23 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_20)) * _SpecColor).x;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_6 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_25.w;
  highp float tmpvar_26;
  tmpvar_26 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lmFull_4 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  lmIndirect_3 = tmpvar_28;
  light_6.xyz = (tmpvar_25.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_29;
  lowp float spec_30;
  mediump float tmpvar_31;
  tmpvar_31 = (tmpvar_25.w * tmpvar_23);
  spec_30 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_21 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_30));
  c_29.xyz = tmpvar_32;
  c_29.w = (tmpvar_10.w + (spec_30 * _SpecColor.w));
  c_2 = c_29;
  c_2.xyz = (c_2.xyz + tmpvar_22.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_6.zw;
  tmpvar_5.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_5.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_12 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD1.zw;
  mediump vec2 cloudUV_8;
  lowp float fresnel_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_11;
  tmpvar_11 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_9 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = pow (fresnel_9, _AtmosFalloff);
  cloudUV_8 = tmpvar_7;
  highp float tmpvar_13;
  tmpvar_13 = (cloudUV_8.x + (_Time * _CloudSpeed).x);
  cloudUV_8.x = tmpvar_13;
  mediump float height_14;
  height_14 = _CloudHeight;
  mediump vec3 viewDir_15;
  viewDir_15 = xlv_TEXCOORD3;
  highp vec3 v_16;
  mediump float tmpvar_17;
  tmpvar_17 = (height_14 - (height_14 / 2.0));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(viewDir_15);
  v_16 = tmpvar_18;
  v_16.z = (v_16.z + 0.42);
  highp vec2 tmpvar_19;
  tmpvar_19 = (cloudUV_8 + (tmpvar_17 * (v_16.xy / v_16.z)));
  cloudUV_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Clouds, cloudUV_8);
  lowp vec3 tmpvar_21;
  tmpvar_21 = ((tmpvar_10.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_12)) * tmpvar_12)) + tmpvar_20.xyz);
  lowp vec3 normal_22;
  normal_22.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_22.z = sqrt((1.0 - clamp (dot (normal_22.xy, normal_22.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_23;
  tmpvar_23 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_20);
  lowp float tmpvar_24;
  tmpvar_24 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_20)) * _SpecColor).x;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_6 = tmpvar_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_26.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp float tmpvar_29;
  tmpvar_29 = ((sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((8.0 * tmpvar_27.w) * tmpvar_27.xyz);
  lmFull_4 = tmpvar_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = ((8.0 * tmpvar_28.w) * tmpvar_28.xyz);
  lmIndirect_3 = tmpvar_31;
  light_6.xyz = (tmpvar_26.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_32;
  lowp float spec_33;
  mediump float tmpvar_34;
  tmpvar_34 = (tmpvar_26.w * tmpvar_24);
  spec_33 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = ((tmpvar_21 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_33));
  c_32.xyz = tmpvar_35;
  c_32.w = (tmpvar_10.w + (spec_33 * _SpecColor.w));
  c_2 = c_32;
  c_2.xyz = (c_2.xyz + tmpvar_23.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 434
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 438
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 458
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 462
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 440
v2f_surf vert_surf( in appdata_full v ) {
    #line 442
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 446
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    #line 450
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 454
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
out highp vec4 xlv_TEXCOORD6;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
    xlv_TEXCOORD6 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 434
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 438
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
#line 458
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 462
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 463
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 466
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    surfIN.uv_Clouds = IN.pack1.zw;
    #line 470
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 474
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 478
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 482
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    #line 486
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    #line 490
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
in highp vec4 xlv_TEXCOORD6;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD6);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_Emission_ST]
Vector 16 [_Clouds_ST]
Vector 17 [_Mask_ST]
"3.0-!!ARBvp1.0
# 28 ALU
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R2.xyz, R2, c[11].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[10].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 28 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
Vector 15 [_Emission_ST]
Vector 16 [_Clouds_ST]
Vector 17 [_Mask_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c18.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c11.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c9.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o2.zw, v3.xyxy, c16.xyxy, c16
mad o2.xy, v3, c15, c15.zwzw
mad o3.xy, v3, c17, c17.zwzw
mad o6.xy, v4, c12, c12.zwzw
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_5;
  mediump vec2 cloudUV_6;
  lowp float fresnel_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_7 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = pow (fresnel_7, _AtmosFalloff);
  cloudUV_6 = tmpvar_4;
  highp float tmpvar_11;
  tmpvar_11 = (cloudUV_6.x + (_Time * _CloudSpeed).x);
  cloudUV_6.x = tmpvar_11;
  mediump float height_12;
  height_12 = _CloudHeight;
  mediump vec3 viewDir_13;
  viewDir_13 = xlv_TEXCOORD3;
  highp vec3 v_14;
  mediump float tmpvar_15;
  tmpvar_15 = (height_12 - (height_12 / 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(viewDir_13);
  v_14 = tmpvar_16;
  v_14.z = (v_14.z + 0.42);
  highp vec2 tmpvar_17;
  tmpvar_17 = (cloudUV_6 + (tmpvar_15 * (v_14.xy / v_14.z)));
  cloudUV_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Clouds, cloudUV_6);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_8.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_10)) * tmpvar_10)) + tmpvar_18.xyz);
  lowp vec3 tmpvar_20;
  tmpvar_20 = mix (((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0), vec3(0.0, 0.0, 1.0), tmpvar_18.xyz);
  lowp vec4 tmpvar_21;
  tmpvar_21 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_18);
  tmpvar_5 = _Shininess;
  lowp float tmpvar_22;
  tmpvar_22 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_18)) * _SpecColor).x;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_25;
  mediump vec3 viewDir_26;
  viewDir_26 = tmpvar_24;
  highp float nh_27;
  mat3 tmpvar_28;
  tmpvar_28[0].x = 0.816497;
  tmpvar_28[0].y = -0.408248;
  tmpvar_28[0].z = -0.408248;
  tmpvar_28[1].x = 0.0;
  tmpvar_28[1].y = 0.707107;
  tmpvar_28[1].z = -0.707107;
  tmpvar_28[2].x = 0.57735;
  tmpvar_28[2].y = 0.57735;
  tmpvar_28[2].z = 0.57735;
  mediump vec3 normal_29;
  normal_29 = tmpvar_20;
  mediump vec3 scalePerBasisVector_30;
  mediump vec3 lm_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz);
  lm_31 = tmpvar_32;
  lowp vec3 tmpvar_33;
  tmpvar_33 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD5).xyz);
  scalePerBasisVector_30 = tmpvar_33;
  lm_31 = (lm_31 * dot (clamp ((tmpvar_28 * normal_29), 0.0, 1.0), scalePerBasisVector_30));
  vec3 v_34;
  v_34.x = tmpvar_28[0].x;
  v_34.y = tmpvar_28[1].x;
  v_34.z = tmpvar_28[2].x;
  vec3 v_35;
  v_35.x = tmpvar_28[0].y;
  v_35.y = tmpvar_28[1].y;
  v_35.z = tmpvar_28[2].y;
  vec3 v_36;
  v_36.x = tmpvar_28[0].z;
  v_36.y = tmpvar_28[1].z;
  v_36.z = tmpvar_28[2].z;
  mediump float tmpvar_37;
  tmpvar_37 = max (0.0, dot (tmpvar_20, normalize((normalize((((scalePerBasisVector_30.x * v_34) + (scalePerBasisVector_30.y * v_35)) + (scalePerBasisVector_30.z * v_36))) + viewDir_26))));
  nh_27 = tmpvar_37;
  mediump float arg1_38;
  arg1_38 = (tmpvar_5 * 128.0);
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = lm_31;
  tmpvar_39.w = pow (nh_27, arg1_38);
  tmpvar_25 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_25);
  light_3 = tmpvar_40;
  lowp vec4 c_41;
  lowp float spec_42;
  mediump float tmpvar_43;
  tmpvar_43 = (tmpvar_40.w * tmpvar_22);
  spec_42 = tmpvar_43;
  mediump vec3 tmpvar_44;
  tmpvar_44 = ((tmpvar_19 * tmpvar_40.xyz) + ((tmpvar_40.xyz * _SpecColor.xyz) * spec_42));
  c_41.xyz = tmpvar_44;
  c_41.w = (tmpvar_8.w + (spec_42 * _SpecColor.w));
  c_2 = c_41;
  c_2.xyz = (c_2.xyz + tmpvar_21.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _Mask_ST;
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Emission_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _Emission_ST.xy) + _Emission_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Mask_ST.xy) + _Mask_ST.zw);
  xlv_TEXCOORD3 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = o_6;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform lowp vec3 _AtmosFar;
uniform lowp vec3 _AtmosNear;
uniform lowp float _Shininess;
uniform lowp float _CloudHeight;
uniform lowp float _CloudSpeed;
uniform lowp float _AtmosFalloff;
uniform lowp float _LightAmount;
uniform sampler2D _Mask;
uniform sampler2D _Clouds;
uniform sampler2D _Emission;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _SpecColor;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  mediump float tmpvar_5;
  mediump vec2 cloudUV_6;
  lowp float fresnel_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - clamp (normalize(xlv_TEXCOORD3).z, 0.0, 1.0));
  fresnel_7 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = pow (fresnel_7, _AtmosFalloff);
  cloudUV_6 = tmpvar_4;
  highp float tmpvar_11;
  tmpvar_11 = (cloudUV_6.x + (_Time * _CloudSpeed).x);
  cloudUV_6.x = tmpvar_11;
  mediump float height_12;
  height_12 = _CloudHeight;
  mediump vec3 viewDir_13;
  viewDir_13 = xlv_TEXCOORD3;
  highp vec3 v_14;
  mediump float tmpvar_15;
  tmpvar_15 = (height_12 - (height_12 / 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(viewDir_13);
  v_14 = tmpvar_16;
  v_14.z = (v_14.z + 0.42);
  highp vec2 tmpvar_17;
  tmpvar_17 = (cloudUV_6 + (tmpvar_15 * (v_14.xy / v_14.z)));
  cloudUV_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Clouds, cloudUV_6);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_8.xyz + (mix (_AtmosNear, _AtmosFar, vec3(tmpvar_10)) * tmpvar_10)) + tmpvar_18.xyz);
  lowp vec3 normal_20;
  normal_20.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_20.z = sqrt((1.0 - clamp (dot (normal_20.xy, normal_20.xy), 0.0, 1.0)));
  lowp vec3 tmpvar_21;
  tmpvar_21 = mix (normal_20, vec3(0.0, 0.0, 1.0), tmpvar_18.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22 = mix ((texture2D (_Emission, xlv_TEXCOORD1.xy) * _LightAmount), vec4(0.0, 0.0, 0.0, 0.0), tmpvar_18);
  tmpvar_5 = _Shininess;
  lowp float tmpvar_23;
  tmpvar_23 = ((texture2D (_Mask, xlv_TEXCOORD2) * (1.0 - tmpvar_18)) * _SpecColor).x;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
  light_3 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_28;
  mediump vec3 viewDir_29;
  viewDir_29 = tmpvar_27;
  highp float nh_30;
  mat3 tmpvar_31;
  tmpvar_31[0].x = 0.816497;
  tmpvar_31[0].y = -0.408248;
  tmpvar_31[0].z = -0.408248;
  tmpvar_31[1].x = 0.0;
  tmpvar_31[1].y = 0.707107;
  tmpvar_31[1].z = -0.707107;
  tmpvar_31[2].x = 0.57735;
  tmpvar_31[2].y = 0.57735;
  tmpvar_31[2].z = 0.57735;
  mediump vec3 normal_32;
  normal_32 = tmpvar_21;
  mediump vec3 scalePerBasisVector_33;
  mediump vec3 lm_34;
  lowp vec3 tmpvar_35;
  tmpvar_35 = ((8.0 * tmpvar_25.w) * tmpvar_25.xyz);
  lm_34 = tmpvar_35;
  lowp vec3 tmpvar_36;
  tmpvar_36 = ((8.0 * tmpvar_26.w) * tmpvar_26.xyz);
  scalePerBasisVector_33 = tmpvar_36;
  lm_34 = (lm_34 * dot (clamp ((tmpvar_31 * normal_32), 0.0, 1.0), scalePerBasisVector_33));
  vec3 v_37;
  v_37.x = tmpvar_31[0].x;
  v_37.y = tmpvar_31[1].x;
  v_37.z = tmpvar_31[2].x;
  vec3 v_38;
  v_38.x = tmpvar_31[0].y;
  v_38.y = tmpvar_31[1].y;
  v_38.z = tmpvar_31[2].y;
  vec3 v_39;
  v_39.x = tmpvar_31[0].z;
  v_39.y = tmpvar_31[1].z;
  v_39.z = tmpvar_31[2].z;
  mediump float tmpvar_40;
  tmpvar_40 = max (0.0, dot (tmpvar_21, normalize((normalize((((scalePerBasisVector_33.x * v_37) + (scalePerBasisVector_33.y * v_38)) + (scalePerBasisVector_33.z * v_39))) + viewDir_29))));
  nh_30 = tmpvar_40;
  mediump float arg1_41;
  arg1_41 = (tmpvar_5 * 128.0);
  highp vec4 tmpvar_42;
  tmpvar_42.xyz = lm_34;
  tmpvar_42.w = pow (nh_30, arg1_41);
  tmpvar_28 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_28);
  light_3 = tmpvar_43;
  lowp vec4 c_44;
  lowp float spec_45;
  mediump float tmpvar_46;
  tmpvar_46 = (tmpvar_43.w * tmpvar_23);
  spec_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = ((tmpvar_19 * tmpvar_43.xyz) + ((tmpvar_43.xyz * _SpecColor.xyz) * spec_45));
  c_44.xyz = tmpvar_47;
  c_44.w = (tmpvar_8.w + (spec_45 * _SpecColor.w));
  c_2 = c_44;
  c_2.xyz = (c_2.xyz + tmpvar_22.xyz);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 437
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
#line 457
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 439
v2f_surf vert_surf( in appdata_full v ) {
    #line 441
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 445
    o.pack1.xy = ((v.texcoord.xy * _Emission_ST.xy) + _Emission_ST.zw);
    o.pack1.zw = ((v.texcoord.xy * _Clouds_ST.xy) + _Clouds_ST.zw);
    o.pack2.xy = ((v.texcoord.xy * _Mask_ST.xy) + _Mask_ST.zw);
    o.screen = ComputeScreenPos( o.pos);
    #line 449
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    #line 453
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec4(xl_retval.pack1);
    xlv_TEXCOORD2 = vec2(xl_retval.pack2);
    xlv_TEXCOORD3 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD4 = vec4(xl_retval.screen);
    xlv_TEXCOORD5 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 394
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec2 uv_Emission;
    highp vec2 uv_Clouds;
    highp vec3 viewDir;
    highp vec2 uv_Mask;
};
#line 422
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec4 pack1;
    highp vec2 pack2;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Emission;
uniform sampler2D _Clouds;
uniform sampler2D _Mask;
uniform lowp float _LightAmount;
uniform lowp float _AtmosFalloff;
uniform lowp float _CloudSpeed;
uniform lowp float _CloudHeight;
uniform lowp float _Shininess;
#line 393
uniform lowp vec3 _AtmosNear;
uniform lowp vec3 _AtmosFar;
#line 404
#line 433
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _Emission_ST;
#line 437
uniform highp vec4 _Clouds_ST;
uniform highp vec4 _Mask_ST;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
#line 457
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 379
mediump vec4 LightingBlinnPhong_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 viewDir, in bool surfFuncWritesNormal, out mediump vec3 specColor ) {
    #line 381
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    mediump vec3 lightDir = normalize((((scalePerBasisVector.x * xll_matrixindex_mf3x3_i (unity_DirBasis, 0)) + (scalePerBasisVector.y * xll_matrixindex_mf3x3_i (unity_DirBasis, 1))) + (scalePerBasisVector.z * xll_matrixindex_mf3x3_i (unity_DirBasis, 2))));
    #line 385
    mediump vec3 h = normalize((lightDir + viewDir));
    highp float nh = max( 0.0, dot( s.Normal, h));
    highp float spec = pow( nh, (s.Specular * 128.0));
    specColor = (((lm * _SpecColor.xyz) * s.Gloss) * spec);
    #line 389
    return vec4( lm, spec);
}
#line 371
lowp vec4 LightingBlinnPhong_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    #line 373
    lowp float spec = (light.w * s.Gloss);
    lowp vec4 c;
    c.xyz = ((s.Albedo * light.xyz) + ((light.xyz * _SpecColor.xyz) * spec));
    c.w = (s.Alpha + (spec * _SpecColor.w));
    #line 377
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 404
void surf( in Input IN, inout SurfaceOutput o ) {
    lowp vec4 c = texture( _MainTex, IN.uv_MainTex);
    lowp float fresnel = (1.0 - xll_saturate_f(dot( normalize(IN.viewDir), vec3( 0.0, 0.0, 1.0))));
    #line 408
    lowp float fresnelPowered = pow( fresnel, _AtmosFalloff);
    lowp vec3 atmosphere = mix( _AtmosNear, _AtmosFar, vec3( fresnelPowered));
    lowp vec3 cleanSky = (c.xyz + (atmosphere * fresnelPowered));
    mediump vec2 cloudUV = IN.uv_Clouds;
    #line 412
    cloudUV.x += float( (_Time * _CloudSpeed));
    cloudUV += ParallaxOffset( 1.0, _CloudHeight, IN.viewDir);
    lowp vec4 clouds = texture( _Clouds, cloudUV);
    o.Albedo = (cleanSky + vec3( clouds));
    #line 416
    o.Normal = mix( UnpackNormal( texture( _BumpMap, IN.uv_BumpMap)), vec3( 0.0, 0.0, 1.0), vec3( clouds));
    o.Emission = vec3( mix( (texture( _Emission, IN.uv_Emission) * _LightAmount), vec4( 0.0), clouds));
    o.Specular = _Shininess;
    o.Gloss = float( ((texture( _Mask, IN.uv_Mask) * (1.0 - clouds)) * _SpecColor));
    #line 420
    o.Alpha = c.w;
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 462
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.uv_Emission = IN.pack1.xy;
    #line 466
    surfIN.uv_Clouds = IN.pack1.zw;
    surfIN.uv_Mask = IN.pack2.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 470
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 474
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 478
    mediump vec3 specColor;
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingBlinnPhong_DirLightmap( o, lmtex, lmIndTex, normalize(IN.viewDir), true, specColor);
    #line 482
    light += lm;
    mediump vec4 c = LightingBlinnPhong_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.pack1 = vec4(xlv_TEXCOORD1);
    xlt_IN.pack2 = vec2(xlv_TEXCOORD2);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD3);
    xlt_IN.screen = vec4(xlv_TEXCOORD4);
    xlt_IN.lmap = vec2(xlv_TEXCOORD5);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 41 to 80, TEX: 5 to 8
//   d3d9 - ALU: 39 to 77, TEX: 5 to 8
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 45 ALU, 5 TEX
PARAM c[9] = { program.local[0..7],
		{ 0.5, 1, 0.41999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[3];
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.y, R0.y;
MUL_SAT R0.w, R0.y, fragment.texcoord[3].z;
ADD R0.w, -R0, c[8].y;
MOV R0.xyz, c[6];
ADD R1.z, R1, c[8];
RCP R1.z, R1.z;
POW R1.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[7];
MAD R2.xyz, R1.w, R0, c[6];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R3.xyz, R2, R1.w, R0;
MOV R0.y, c[4].x;
MOV R0.x, c[8];
MUL R1.xy, R1, R1.z;
MAD R0.x, -R0, c[5], c[5];
MUL R1.xy, R0.x, R1;
MUL R0.y, R0, c[0].x;
ADD R0.x, fragment.texcoord[1].z, R0.y;
MOV R0.y, fragment.texcoord[1].w;
ADD R0.xy, R0, R1;
TXP R1, fragment.texcoord[4], texture[5], 2D;
TEX R0.xyz, R0, texture[1], 2D;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R2.xyz, -R1, fragment.texcoord[5];
ADD R1.y, -R0.x, c[8];
TEX R1.x, fragment.texcoord[2], texture[4], 2D;
MUL R1.x, R1, R1.y;
MUL R2.w, R1.x, c[1].x;
LG2 R1.w, R1.w;
MUL R1.w, -R1, R2;
MUL R4.xyz, R2, c[1];
TEX R1.xyz, fragment.texcoord[1], texture[3], 2D;
ADD R3.xyz, R3, R0;
MUL R1.xyz, R1, c[2].x;
MAD R0.xyz, R0, -R1, R1;
MUL R4.xyz, R4, R1.w;
MAD R1.xyz, R3, R2, R4;
ADD result.color.xyz, R1, R0;
MAD result.color.w, R1, c[1], R0;
END
# 45 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
"ps_3_0
; 43 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 1.00000000, 0.41999999, -0.50000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul_sat r0.x, r0, v3.z
add r1.x, -r0, c8
pow_pp r0, r1.x, c3.x
mov_pp r1.w, r0.x
dp3_pp r0.w, v3, v3
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v3
mov_pp r0.xyz, c7
add_pp r0.xyz, -c6, r0
mad_pp r2.xyz, r1.w, r0, c6
texld r0, v0, s0
mad_pp r2.xyz, r2, r1.w, r0
add r1.z, r1, c8.y
rcp r1.z, r1.z
mov r0.x, c0
mov_pp r0.y, c8.z
mul r0.x, c4, r0
mul r1.xy, r1, r1.z
mad_pp r0.y, r0, c5.x, c5.x
mul r1.xy, r0.y, r1
add_pp r0.x, v1.z, r0
mov_pp r0.y, v1.w
add_pp r0.xy, r0, r1
texldp r1, v4, s5
texld r0.xyz, r0, s1
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
add_pp r3.xyz, -r1, v5
add_pp r1.y, -r0.x, c8.x
texld r1.x, v2, s4
mul r1.x, r1, r1.y
mul r2.w, r1.x, c1.x
log_pp r1.w, r1.w
mul_pp r1.w, -r1, r2
mul_pp r4.xyz, r3, c1
texld r1.xyz, v1, s3
add_pp r2.xyz, r2, r0
mul r1.xyz, r1, c2.x
mad r0.xyz, r0, -r1, r1
mul_pp r4.xyz, r4, r1.w
mad_pp r1.xyz, r2, r3, r4
add_pp oC0.xyz, r1, r0
mad_pp oC0.w, r1, c1, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
Vector 8 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 56 ALU, 7 TEX
PARAM c[10] = { program.local[0..8],
		{ 0.5, 8, 1, 0.41999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[5], texture[7], 2D;
MUL R1.xyz, R0.w, R0;
TEX R0, fragment.texcoord[5], texture[6], 2D;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1, c[9].y;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, fragment.texcoord[3];
ADD R1.w, R2.z, c[9];
RCP R1.w, R1.w;
MUL R2.zw, R2.xyxy, R1.w;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MOV R2.x, c[4];
MOV R1.w, c[9].x;
MAD R1.w, -R1, c[5].x, c[5].x;
MUL R2.x, R2, c[0];
MUL R2.zw, R1.w, R2;
MAD R0.xyz, R0, c[9].y, -R1;
MAD_SAT R0.w, R0, c[8].z, c[8];
MAD R1.xyz, R0.w, R0, R1;
TXP R0, fragment.texcoord[4], texture[5], 2D;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R3.xyz, -R0, R1;
MUL R0.xyz, R3, c[1];
LG2 R0.w, R0.w;
ADD R2.x, fragment.texcoord[1].z, R2;
MOV R2.y, fragment.texcoord[1].w;
ADD R2.xy, R2, R2.zwzw;
TEX R1.xyz, R2, texture[1], 2D;
ADD R1.w, -R1.x, c[9].z;
TEX R2.x, fragment.texcoord[2], texture[4], 2D;
MUL R1.w, R2.x, R1;
MUL R1.w, R1, c[1].x;
MUL R1.w, -R0, R1;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R2.x;
MUL R5.xyz, R0, R1.w;
MUL_SAT R0.w, R0, fragment.texcoord[3].z;
ADD R0.w, -R0, c[9].z;
MOV R0.xyz, c[6];
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
POW R2.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[7];
MAD R4.xyz, R2.w, R0, c[6];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R2.w, R0;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[2].x;
MAD R1.xyz, R1, -R2, R2;
MAD R0.xyz, R0, R3, R5;
ADD result.color.xyz, R0, R1;
MAD result.color.w, R1, c[1], R0;
END
# 56 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
Vector 8 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"ps_3_0
; 52 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c9, 1.00000000, 0.41999999, -0.50000000, 8.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
texld r0, v5, s6
mul_pp r1.xyz, r0.w, r0
texld r0, v5, s7
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c9.w
dp4 r1.w, v6, v6
rsq r0.w, r1.w
rcp r0.w, r0.w
mad_pp r1.xyz, r1, c9.w, -r0
mad_sat r0.w, r0, c8.z, c8
mad_pp r2.xyz, r0.w, r1, r0
texldp r0, v4, s5
log_pp r1.w, r0.w
dp3_pp r1.x, v3, v3
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, v3
add r1.z, r1, c9.y
rcp r1.z, r1.z
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mul r1.xy, r1, r1.z
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r4.xyz, -r0, r2
mov r0.x, c0
mov_pp r0.y, c9.z
mad_pp r0.y, r0, c5.x, c5.x
mul r1.xy, r0.y, r1
mul r0.x, c4, r0
add_pp r0.x, v1.z, r0
mov_pp r0.y, v1.w
add_pp r1.xy, r0, r1
texld r1.xyz, r1, s1
add_pp r2.y, -r1.x, c9.x
texld r2.x, v2, s4
mul r2.x, r2, r2.y
mul r2.x, r2, c1
mul_pp r1.w, -r1, r2.x
mul_pp r0.xyz, r4, c1
mul_sat r0.w, r0, v3.z
add r2.x, -r0.w, c9
mul_pp r5.xyz, r0, r1.w
pow_pp r0, r2.x, c3.x
mov_pp r2.w, r0.x
texld r0, v0, s0
mov_pp r2.xyz, c7
add_pp r2.xyz, -c6, r2
mad_pp r3.xyz, r2.w, r2, c6
texld r2.xyz, v1, s3
mad_pp r0.xyz, r3, r2.w, r0
add_pp r0.xyz, r0, r1
mul r2.xyz, r2, c2.x
mad r1.xyz, r1, -r2, r2
mad_pp r0.xyz, r0, r4, r5
add_pp oC0.xyz, r0, r1
mad_pp oC0.w, r1, c1, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 80 ALU, 8 TEX
PARAM c[13] = { program.local[0..8],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 0.81649655, 0.57735026 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[5], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
MUL R4.xyz, R0, c[11].w;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.x;
MUL R1.xyz, R4.y, c[12];
MAD R0.xyz, R4.x, c[10].zxww, R1;
MAD R3.xyz, R4.z, c[11], R0;
MUL R1.xyz, R0.w, fragment.texcoord[3];
ADD R0.x, R1.z, c[9].z;
RCP R0.z, R0.x;
MUL R1.xy, R1, R0.z;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R0.xy, R2.wyzw, c[9].w, -c[9].x;
MUL R1.zw, R0.xyxy, R0.xyxy;
MOV R0.z, c[9].y;
ADD_SAT R2.x, R1.z, R1.w;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.zw, R0.z, R1.xyxy;
ADD R1.x, -R2, c[9];
RSQ R1.y, R1.x;
MOV R0.z, c[4].x;
MUL R1.x, R0.z, c[0];
RCP R0.z, R1.y;
ADD R2.xyz, -R0, c[10].xxyw;
ADD R1.x, fragment.texcoord[1].z, R1;
MOV R1.y, fragment.texcoord[1].w;
ADD R1.xy, R1, R1.zwzw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R2.xyz, R1, R2, R0;
DP3 R0.x, R3, R3;
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, R3;
MAD R3.xyz, fragment.texcoord[3], R0.w, R3;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
DP3_SAT R0.z, R2, c[11];
DP3_SAT R0.y, R2, c[12];
DP3_SAT R0.x, R2, c[10].zxww;
DP3 R1.w, R0, R4;
TEX R0, fragment.texcoord[5], texture[6], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1.w;
MUL R3.xyz, R2.w, R3;
DP3 R1.w, R2, R3;
TXP R2, fragment.texcoord[4], texture[5], 2D;
MOV R0.w, c[12];
TEX R3.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R0.xyz, R0, c[11].w;
MAX R1.w, R1, c[10].x;
MUL R0.w, R0, c[6].x;
POW R0.w, R1.w, R0.w;
LG2 R2.x, R2.x;
LG2 R2.y, R2.y;
LG2 R2.z, R2.z;
LG2 R2.w, R2.w;
ADD R2, -R2, R0;
ADD R0.y, -R1.x, c[9].x;
TEX R0.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.w, R0.x, R0.y;
MUL R1.w, R0, c[1].x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MUL_SAT R0.w, R0, fragment.texcoord[3].z;
MUL R1.w, R2, R1;
MUL R0.xyz, R2, c[1];
MUL R5.xyz, R0, R1.w;
ADD R0.w, -R0, c[9].x;
MOV R0.xyz, c[7];
POW R2.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[8];
MAD R4.xyz, R2.w, R0, c[7];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R2.w, R0;
ADD R0.xyz, R0, R1;
MUL R3.xyz, R3, c[2].x;
MAD R1.xyz, R1, -R3, R3;
MAD R0.xyz, R0, R2, R5;
ADD result.color.xyz, R0, R1;
MAD result.color.w, R1, c[1], R0;
END
# 80 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"ps_3_0
; 77 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c9, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c10, 2.00000000, -1.00000000, 8.00000000, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 0
def c12, -0.40824831, 0.70710677, 0.57735026, 0
def c13, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r0, v5, s7
mul_pp r0.xyz, r0.w, r0
mul_pp r4.xyz, r0, c10.z
dp3_pp r0.x, v3, v3
rsq_pp r0.w, r0.x
mul r1.xyz, r4.y, c12
mad r0.xyz, r4.x, c13, r1
mad r3.xyz, r4.z, c11, r0
mul_pp r1.xyz, r0.w, v3
add r0.x, r1.z, c9.z
rcp r0.z, r0.x
mul r1.xy, r1, r0.z
texld r2.yw, v0.zwzw, s2
mad_pp r0.xy, r2.wyzw, c10.x, c10.y
mul_pp r1.zw, r0.xyxy, r0.xyxy
mov_pp r0.z, c9.y
add_pp_sat r2.x, r1.z, r1.w
mad_pp r0.z, r0, c5.x, c5.x
mul r1.zw, r0.z, r1.xyxy
add_pp r1.x, -r2, c9
rsq_pp r1.y, r1.x
mov r0.z, c0.x
mul r1.x, c4, r0.z
rcp_pp r0.z, r1.y
add_pp r2.xyz, -r0, c9.wwxw
add_pp r1.x, v1.z, r1
mov_pp r1.y, v1.w
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r2.xyz, r1, r2, r0
dp3 r0.x, r3, r3
rsq r0.x, r0.x
mul r3.xyz, r0.x, r3
mad_pp r3.xyz, v3, r0.w, r3
dp3_pp r2.w, r3, r3
rsq_pp r2.w, r2.w
mul_pp r3.xyz, r2.w, r3
dp3_pp_sat r0.z, r2, c11
dp3_pp_sat r0.y, r2, c12
dp3_pp_sat r0.x, r2, c13
dp3_pp r1.w, r0, r4
texld r0, v5, s6
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.w, r2, r3
mul_pp r0.xyz, r0, r1.w
mov_pp r1.w, c6.x
mul_pp r1.w, c10, r1
max_pp r0.w, r0, c9
pow r2, r0.w, r1.w
mul_pp r2.xyz, r0, c10.z
texldp r0, v4, s5
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
log_pp r0.w, r0.w
add_pp r2, -r0, r2
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mul_pp r0.xyz, r2, c1
add_pp r1.w, -r1.x, c9.x
texld r3.x, v2, s4
mul r1.w, r3.x, r1
mul r1.w, r1, c1.x
mul_pp r1.w, r2, r1
mul_sat r0.w, r0, v3.z
mov_pp r3.xyz, c8
add r2.w, -r0, c9.x
mul_pp r5.xyz, r0, r1.w
pow_pp r0, r2.w, c3.x
mov_pp r2.w, r0.x
add_pp r3.xyz, -c7, r3
mad_pp r4.xyz, r2.w, r3, c7
texld r0, v0, s0
texld r3.xyz, v1, s3
mad_pp r0.xyz, r4, r2.w, r0
add_pp r0.xyz, r0, r1
mul r3.xyz, r3, c2.x
mad r1.xyz, r1, -r3, r3
mad_pp r0.xyz, r0, r2, r5
add_pp oC0.xyz, r0, r1
mad_pp oC0.w, r1, c1, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 41 ALU, 5 TEX
PARAM c[9] = { program.local[0..7],
		{ 0.5, 1, 0.41999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[3];
ADD R0.z, R0, c[8];
RCP R0.z, R0.z;
MUL R0.zw, R0.xyxy, R0.z;
MOV R0.y, c[4].x;
MOV R0.x, c[8];
MAD R0.x, -R0, c[5], c[5];
MOV R2.xyz, c[6];
MUL R0.zw, R0.x, R0;
MUL R0.y, R0, c[0].x;
ADD R0.x, fragment.texcoord[1].z, R0.y;
MOV R0.y, fragment.texcoord[1].w;
ADD R0.xy, R0, R0.zwzw;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MUL_SAT R0.w, R0, fragment.texcoord[3].z;
ADD R0.w, -R0, c[8].y;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0.xyz, R0, texture[1], 2D;
POW R0.w, R0.w, c[3].x;
ADD R2.xyz, -R2, c[7];
MAD R2.xyz, R0.w, R2, c[6];
MAD R2.xyz, R2, R0.w, R1;
ADD R3.xyz, R2, R0;
TXP R2, fragment.texcoord[4], texture[5], 2D;
ADD R2.xyz, R2, fragment.texcoord[5];
ADD R0.w, -R0.x, c[8].y;
TEX R1.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, c[1].x;
MUL R0.w, R2, R0;
TEX R1.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R1.xyz, R1, c[2].x;
MUL R4.xyz, R2, c[1];
MAD R0.xyz, R0, -R1, R1;
MUL R4.xyz, R4, R0.w;
MAD R1.xyz, R3, R2, R4;
ADD result.color.xyz, R1, R0;
MAD result.color.w, R0, c[1], R1;
END
# 41 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
"ps_3_0
; 39 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 1.00000000, 0.41999999, -0.50000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v3
add r0.x, r1.z, c8.y
rcp r0.y, r0.x
mul r0.zw, r1.xyxy, r0.y
mov_pp r0.x, c8.z
mad_pp r0.x, r0, c5, c5
mul r1.xy, r0.x, r0.zwzw
dp3 r0.x, v3, v3
rsq r0.z, r0.x
mul_sat r0.w, r0.z, v3.z
add r0.w, -r0, c8.x
pow_pp r2, r0.w, c3.x
mov r0.y, c0.x
mul r0.y, c4.x, r0
add_pp r0.x, v1.z, r0.y
mov_pp r0.y, v1.w
add_pp r0.xy, r0, r1
mov_pp r3.xyz, c7
texld r1, v0, s0
mov_pp r0.w, r2.x
add_pp r3.xyz, -c6, r3
mad_pp r2.xyz, r0.w, r3, c6
mad_pp r2.xyz, r2, r0.w, r1
texld r0.xyz, r0, s1
texldp r3, v4, s5
add_pp r3.xyz, r3, v5
add_pp r0.w, -r0.x, c8.x
texld r1.x, v2, s4
mul r0.w, r1.x, r0
mul r0.w, r0, c1.x
mul_pp r0.w, r3, r0
texld r1.xyz, v1, s3
mul_pp r4.xyz, r3, c1
add_pp r2.xyz, r2, r0
mul r1.xyz, r1, c2.x
mad r0.xyz, r0, -r1, r1
mul_pp r4.xyz, r4, r0.w
mad_pp r1.xyz, r2, r3, r4
add_pp oC0.xyz, r1, r0
mad_pp oC0.w, r0, c1, r1
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
Vector 8 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 52 ALU, 7 TEX
PARAM c[10] = { program.local[0..8],
		{ 0.5, 8, 1, 0.41999999 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[5], texture[6], 2D;
MUL R1.xyz, R0.w, R0;
TEX R0, fragment.texcoord[5], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[9].y;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, fragment.texcoord[3];
ADD R0.w, R2.z, c[9];
RCP R1.w, R0.w;
MUL R2.xy, R2, R1.w;
MOV R0.w, c[9].x;
MAD R0.w, -R0, c[5].x, c[5].x;
MUL R2.xy, R0.w, R2;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MOV R1.w, c[4].x;
MUL R1.w, R1, c[0].x;
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[9].y, -R0;
ADD R2.z, fragment.texcoord[1], R1.w;
MOV R2.w, fragment.texcoord[1];
ADD R3.xy, R2.zwzw, R2;
MAD_SAT R0.w, R0, c[8].z, c[8];
MAD R2.xyz, R0.w, R1, R0;
TXP R0, fragment.texcoord[4], texture[5], 2D;
TEX R1.xyz, R3, texture[1], 2D;
ADD R3.xyz, R0, R2;
ADD R0.y, -R1.x, c[9].z;
TEX R0.x, fragment.texcoord[2], texture[4], 2D;
MUL R1.w, R0.x, R0.y;
MUL R1.w, R1, c[1].x;
MUL R1.w, R0, R1;
MUL R0.xyz, R3, c[1];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R2.x;
MUL R5.xyz, R0, R1.w;
MUL_SAT R0.w, R0, fragment.texcoord[3].z;
ADD R0.w, -R0, c[9].z;
MOV R0.xyz, c[6];
TEX R2.xyz, fragment.texcoord[1], texture[3], 2D;
POW R2.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[7];
MAD R4.xyz, R2.w, R0, c[6];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R2.w, R0;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[2].x;
MAD R1.xyz, R1, -R2, R2;
MAD R0.xyz, R0, R3, R5;
ADD result.color.xyz, R0, R1;
MAD result.color.w, R1, c[1], R0;
END
# 52 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Vector 6 [_AtmosNear]
Vector 7 [_AtmosFar]
Vector 8 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"ps_3_0
; 48 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c9, 1.00000000, 0.41999999, -0.50000000, 8.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
dp3_pp r0.x, v3, v3
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v3
add r0.x, r1.z, c9.y
rcp r0.y, r0.x
mul r0.zw, r1.xyxy, r0.y
mov_pp r0.x, c9.z
mad_pp r0.x, r0, c5, c5
mul r1.xy, r0.x, r0.zwzw
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul_sat r0.z, r0.x, v3
mov r0.y, c0.x
mul r0.y, c4.x, r0
add_pp r0.x, v1.z, r0.y
mov_pp r0.y, v1.w
add_pp r3.xy, r0, r1
add r2.x, -r0.z, c9
pow_pp r1, r2.x, c3.x
mov_pp r2.xyz, c7
mov_pp r1.w, r1.x
add_pp r2.xyz, -c6, r2
mad_pp r1.xyz, r1.w, r2, c6
texld r0, v0, s0
mad_pp r2.xyz, r1, r1.w, r0
texld r0.xyz, r3, s1
texld r1, v5, s6
mul_pp r3.xyz, r1.w, r1
texld r1, v5, s7
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c9.w
dp4 r2.w, v6, v6
rsq r1.w, r2.w
rcp r1.w, r1.w
mad_pp r3.xyz, r3, c9.w, -r1
mad_sat r1.w, r1, c8.z, c8
mad_pp r3.xyz, r1.w, r3, r1
texldp r1, v4, s5
add_pp r3.xyz, r1, r3
add_pp r1.y, -r0.x, c9.x
texld r1.x, v2, s4
mul r1.x, r1, r1.y
mul r2.w, r1.x, c1.x
mul_pp r1.w, r1, r2
mul_pp r4.xyz, r3, c1
texld r1.xyz, v1, s3
add_pp r2.xyz, r2, r0
mul r1.xyz, r1, c2.x
mad r0.xyz, r0, -r1, r1
mul_pp r4.xyz, r4, r1.w
mad_pp r1.xyz, r2, r3, r4
add_pp oC0.xyz, r1, r0
mad_pp oC0.w, r1, c1, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 76 ALU, 8 TEX
PARAM c[13] = { program.local[0..8],
		{ 1, 0.5, 0.41999999, 2 },
		{ 0, 1, 0.81649655, 0.57735026 },
		{ -0.40824828, -0.70710677, 0.57735026, 8 },
		{ -0.40824831, 0.70710677, 0.57735026, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[5], texture[7], 2D;
MUL R1.xyz, R0.w, R0;
MUL R3.xyz, R1, c[11].w;
MUL R1.xyz, R3.y, c[12];
MAD R4.xyz, R3.x, c[10].zxww, R1;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R2.xy, R1.wyzw, c[9].w, -c[9].x;
MUL R1.xy, R2, R2;
MAD R4.xyz, R3.z, c[11], R4;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.x;
MUL R0.xyz, R0.w, fragment.texcoord[3];
DP3 R1.w, R4, R4;
RSQ R1.w, R1.w;
ADD R0.z, R0, c[9];
RCP R0.z, R0.z;
MUL R0.xy, R0, R0.z;
MOV R0.z, c[9].y;
ADD_SAT R1.z, R1.x, R1.y;
MAD R0.z, -R0, c[5].x, c[5].x;
MUL R1.xy, R0.z, R0;
ADD R0.y, -R1.z, c[9].x;
RSQ R0.y, R0.y;
RCP R2.z, R0.y;
MOV R0.x, c[4];
MUL R0.x, R0, c[0];
MUL R4.xyz, R1.w, R4;
ADD R0.x, fragment.texcoord[1].z, R0;
MOV R0.y, fragment.texcoord[1].w;
ADD R1.xy, R0, R1;
ADD R0.xyz, -R2, c[10].xxyw;
TEX R1.xyz, R1, texture[1], 2D;
MAD R0.xyz, R1, R0, R2;
DP3_SAT R2.z, R0, c[11];
DP3_SAT R2.y, R0, c[12];
DP3_SAT R2.x, R0, c[10].zxww;
DP3 R1.w, R2, R3;
MAD R3.xyz, fragment.texcoord[3], R0.w, R4;
TEX R2, fragment.texcoord[5], texture[6], 2D;
DP3 R0.w, R3, R3;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, R1.w;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R3;
DP3 R0.x, R0, R3;
MOV R0.w, c[12];
TEX R3.xyz, fragment.texcoord[1], texture[3], 2D;
MUL R0.y, R0.w, c[6].x;
MAX R0.x, R0, c[10];
POW R2.w, R0.x, R0.y;
TXP R0, fragment.texcoord[4], texture[5], 2D;
MUL R2.xyz, R2, c[11].w;
ADD R2, R0, R2;
ADD R0.y, -R1.x, c[9].x;
TEX R0.x, fragment.texcoord[2], texture[4], 2D;
MUL R0.w, R0.x, R0.y;
MUL R1.w, R0, c[1].x;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MUL_SAT R0.w, R0, fragment.texcoord[3].z;
MUL R1.w, R2, R1;
MUL R0.xyz, R2, c[1];
MUL R5.xyz, R0, R1.w;
ADD R0.w, -R0, c[9].x;
MOV R0.xyz, c[7];
POW R2.w, R0.w, c[3].x;
ADD R0.xyz, -R0, c[8];
MAD R4.xyz, R2.w, R0, c[7];
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R0.xyz, R4, R2.w, R0;
ADD R0.xyz, R0, R1;
MUL R3.xyz, R3, c[2].x;
MAD R1.xyz, R1, -R3, R3;
MAD R0.xyz, R0, R2, R5;
ADD result.color.xyz, R0, R1;
MAD result.color.w, R1, c[1], R0;
END
# 76 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_SpecColor]
Float 2 [_LightAmount]
Float 3 [_AtmosFalloff]
Float 4 [_CloudSpeed]
Float 5 [_CloudHeight]
Float 6 [_Shininess]
Vector 7 [_AtmosNear]
Vector 8 [_AtmosFar]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Clouds] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_Emission] 2D
SetTexture 4 [_Mask] 2D
SetTexture 5 [_LightBuffer] 2D
SetTexture 6 [unity_Lightmap] 2D
SetTexture 7 [unity_LightmapInd] 2D
"ps_3_0
; 74 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c9, 1.00000000, -0.50000000, 0.41999999, 0.00000000
def c10, 2.00000000, -1.00000000, 8.00000000, 128.00000000
def c11, -0.40824828, -0.70710677, 0.57735026, 0
def c12, -0.40824831, 0.70710677, 0.57735026, 0
def c13, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r0, v5, s7
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r0, c10.z
mul r0.xyz, r2.y, c12
mad r0.xyz, r2.x, c13, r0
mad r1.xyz, r2.z, c11, r0
dp3 r0.x, r1, r1
rsq r0.y, r0.x
dp3_pp r0.x, v3, v3
texld r3.yw, v0.zwzw, s2
mad_pp r3.xy, r3.wyzw, c10.x, c10.y
rsq_pp r0.w, r0.x
mul r1.xyz, r0.y, r1
mad_pp r0.xyz, v3, r0.w, r1
mul_pp r1.xyz, r0.w, v3
dp3_pp r1.w, r0, r0
rsq_pp r0.w, r1.w
mul_pp r0.xyz, r0.w, r0
add r1.z, r1, c9
rcp r1.z, r1.z
mul r1.xy, r1, r1.z
mul_pp r1.zw, r3.xyxy, r3.xyxy
add_pp_sat r3.z, r1, r1.w
mov_pp r2.w, c9.y
mad_pp r1.z, r2.w, c5.x, c5.x
mul r1.zw, r1.z, r1.xyxy
add_pp r1.y, -r3.z, c9.x
rsq_pp r1.y, r1.y
rcp_pp r3.z, r1.y
mov_pp r0.w, c6.x
mov r1.x, c0
mul r1.x, c4, r1
add_pp r4.xyz, -r3, c9.wwxw
mul_pp r2.w, c10, r0
add_pp r1.x, v1.z, r1
mov_pp r1.y, v1.w
add_pp r1.xy, r1, r1.zwzw
texld r1.xyz, r1, s1
mad_pp r3.xyz, r1, r4, r3
dp3_pp r0.x, r3, r0
max_pp r1.w, r0.x, c9
pow r0, r1.w, r2.w
dp3_pp_sat r0.z, r3, c11
dp3_pp_sat r0.y, r3, c12
dp3_pp_sat r0.x, r3, c13
dp3_pp r1.w, r0, r2
texld r3, v5, s6
mul_pp r0.xyz, r3.w, r3
mul_pp r0.xyz, r0, r1.w
mul_pp r2.xyz, r0, c10.z
mov r2.w, r0
texldp r0, v4, s5
add_pp r2, r0, r2
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mul_pp r0.xyz, r2, c1
add_pp r1.w, -r1.x, c9.x
texld r3.x, v2, s4
mul r1.w, r3.x, r1
mul r1.w, r1, c1.x
mul_pp r1.w, r2, r1
mul_sat r0.w, r0, v3.z
mov_pp r3.xyz, c8
add r2.w, -r0, c9.x
mul_pp r5.xyz, r0, r1.w
pow_pp r0, r2.w, c3.x
mov_pp r2.w, r0.x
add_pp r3.xyz, -c7, r3
mad_pp r4.xyz, r2.w, r3, c7
texld r0, v0, s0
texld r3.xyz, v1, s3
mad_pp r0.xyz, r4, r2.w, r0
add_pp r0.xyz, r0, r1
mul r3.xyz, r3, c2.x
mad r1.xyz, r1, -r3, r3
mad_pp r0.xyz, r0, r2, r5
add_pp oC0.xyz, r0, r1
mad_pp oC0.w, r1, c1, r0
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

}
	}

#LINE 62

	} 
	FallBack "Diffuse"
}
