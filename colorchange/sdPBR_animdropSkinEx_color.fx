#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    //��{�̐ݒ�
    m.subsurface = 0.5;
    m.roughness = 1;
    m.specular = 0.35;
    m.clearcoat = 0.3;
    m.clearcoatGloss = 0.3;

    //���̃m�[�}���E���t�l�X�}�b�v
    m.normalLoops = 15;
    m.normalScale = 0.8;
    m.roughnessLoops = 15;

    //���H�p�T�u�m�[�}���E�T�u���t�l�X�}�b�v
    m.subNormalLoops = 8;
    m.subNormalScale = 0.7;
    m.subRoughnessLoops = 8;
}

#define PREINTEGRATED_SKIN

#define ANIMATED_TEXTURE_PACK1 "../../texture/animdrop.png"
#define SUBNORMAL_FROM FROM_PACK1
#define SUBROUGHNESS_FROM FROM_PACK1
#define SUBROUGHNESS_CHANNEL b

#define TEXTURE_PACK0 "../../texture/skin2pack.png"
#define NORMAL_FROM NORMAL_FROM_PACK0
#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b

#include "../../shader/sdPBRMaterialTail.fxsub"
