#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

/* �ݒ�p�̒萔 */

//���H���͂̉e�̔Z��
const float _Droplet_Shadow = 0.25;

//�A�j���[�V���� �T�u�@���}�b�v
texture _AnimDropMap : ANIMATEDTEXTURE < string ResourceName = "../../texture/animdrop.png";>;
sampler _AnimDropSamp = sampler_state {
    Texture = <_AnimDropMap>;
    MinFilter = ANISOTROPIC; MagFilter = ANISOTROPIC; MipFilter = LINEAR; MaxAnisotropy = MAX_ANISOTROPY;
    ADDRESSU = WRAP; ADDRESSV = WRAP;
};

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    //��{�̐ݒ�
    m.subsurface = 0.5;
    m.roughness = 0.55;
    m.specular = 0.35;
    m.clearcoat = 0.3;
    m.clearcoatGloss = 0.3;

    //���̃m�[�}���E���t�l�X�}�b�v
    m.normalLoops = 15;
    m.normalScale = 0.8;
    m.roughnessLoops = 15;

    //���H�p�T�u�m�[�}���E�T�u���t�l�X�}�b�v
    m.subNormalLoops = 8;
    m.subNormalScale = 3;
    m.subRoughnessLoops = 8;
}

float2 _GetSubNormal(inout Material m, float3 n, float3 Eye, float2 uv)
{
    float4 t = tex2D(_AnimDropSamp, uv);
    m.roughness *= t.b;   //subroughness����

    //m.baseColor = lerp(0.7,m.baseColor,exp(-(1-t.b))); //�Ȃ�ł����˂��A�����

    m.baseColor *= 1 - saturate(length(t.xy*2-1))*_Droplet_Shadow; //����AO�ɂ�鐅�H�̉e
    return t.rg;
}

#define PREINTEGRATED_SKIN
//#define IRIDESCENCE

#define SUBNORMAL_DROPLET

#define SUBNORMAL_FROM FROM_CODE
#define SUBNORMAL_CODE _GetSubNormal

#define TEXTURE_PACK0 "../../texture/skin2pack.png"
#define NORMAL_FROM NORMAL_FROM_PACK0
#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b

#include "../../shader/sdPBRMaterialTail.fxsub"
