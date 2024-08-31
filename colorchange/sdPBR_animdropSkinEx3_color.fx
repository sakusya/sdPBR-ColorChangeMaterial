#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

/* �ݒ�p�̒萔 */

//���H���͂̉e�̔Z��
const float _Droplet_Shadow = 0.25;

//�A�j���[�V���� �T�u�@���}�b�v �R�[�X�e�B�N�X�Ή���
texture3D _DropMap< string ResourceName = "../../texture/animdrop3D.dds";>;
sampler3D _DropSamp = sampler_state {
    Texture = <_DropMap>;
    MinFilter = LINEAR; MagFilter = LINEAR; MipFilter = LINEAR;
    ADDRESSU = WRAP; ADDRESSV = WRAP; ADDRESSW = WRAP;
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
    m.subNormalScale = -1;
}

float2 _GetSubNormal(inout Material m, float3 n, float3 Eye, float2 uv)
{
    float4 t = tex3D(_DropSamp, float3(uv,frac(ftime/10)));
    m.roughness *= smoothstep(0.1,0.01,t.b);
    m.baseColor *= t.a*4;
    return t.rg;
}

#define PREINTEGRATED_SKIN

#define SUBNORMAL_DROPLET

#define SUBNORMAL_FROM FROM_CODE
#define SUBNORMAL_CODE _GetSubNormal

#define TEXTURE_PACK0 "../../texture/skin2pack.png"
#define NORMAL_FROM NORMAL_FROM_PACK0
#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b

#include "../../shader/sdPBRMaterialTail.fxsub"
