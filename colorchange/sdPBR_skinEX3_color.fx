#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;


//skinEX2���x�[�X�ɋȗ��𐄒肷�镔������ꂽ�o���G�[�V����
//���̋l�܂��Ă��銴�����o�܂�
void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    float c = saturate(length(fwidth(n)) / length(fwidth(Eye*80))); //�ȗ�[1/mm]  80��MMD������mm�ւ̕ϊ��W��
    //�ȗ����̂܂܂��ƃ|�����肪�ڗ����������̂�0�`1 �� 0.25�`0.75�Ƀ��}�b�v���Ĕ��߂�
    //����܂�ǂ����ł͂Ȃ��񂾂��ǃK�^�K�^������̓��V
    m.subsurface = lerp(0.25,0.75,c);
    m.specular = 0.35;
    m.roughness = 0.5;
    m.clearcoat = 1;
    m.clearcoatGloss = 0.8;
    m.normalLoops = 15;
    m.normalScale = 0.8;
    m.roughnessLoops = 15;
}

#define PREINTEGRATED_SKIN
#define TEXTURE_PACK0 "../../texture/skin2pack.png"

#define NORMAL_FROM NORMAL_FROM_PACK0
#define NORMAL_CHANNEL rg

#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b


#include "../../shader/sdPBRMaterialTail.fxsub"
