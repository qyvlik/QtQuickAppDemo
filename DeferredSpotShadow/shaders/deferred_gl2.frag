#version 130
#extension GL_ARB_uniform_buffer_object : enable

uniform sampler2D color;
uniform sampler2D position;
uniform sampler2D normal;
uniform vec2 winSize;

struct PointLight
{
    vec3 position;
    vec3 direction;
    vec4 color;
    float intensity;
};

struct SpotLight
{
    vec3 position;
    vec3 direction;
    vec4 color;
    float intensity;
    float cutOffAngle;
};

const int pointLightCount = 2;
const int spotLightCount = 1;

uniform PointLightBlock {
    PointLight pointLights[pointLightCount];
};

uniform SpotLightBlock {
    SpotLight spotLights[spotLightCount];
};

void main()
{
    vec2 texCoord = gl_FragCoord.xy / winSize;
    vec4 col = texture2D(color, texCoord);
    vec3 pos = texture2D(position, texCoord).xyz;
    vec3 norm = texture2D(normal, texCoord).xyz;

    vec4 lightColor;
    for (int i = 0; i < pointLightCount; i++) {
	vec3 s = pointLights[i].position - pos;
	lightColor += pointLights[i].color * (pointLights[i].intensity * max(dot(s, norm), 0.0));
    }

    for (int j = 0; j < spotLightCount; j++) {
        vec3 s = normalize(spotLights[j].position - pos);
        float angle = acos( dot(-s, spotLights[j].direction) );
        float cutoff = radians( clamp( spotLights[j].cutOffAngle, 0.0, 90.0 ) );
        if( angle < cutoff )
        {
            float spotFactor = pow( dot(-s, spotLights[j].direction), 5 ); // fixed attenuation of 5 degrees
            vec3 v = normalize(vec3(-pos));

            lightColor += spotLights[j].color * (spotFactor * spotLights[j].intensity * max(dot(s, norm), 0.0));
        }
    }
    lightColor /= float(pointLightCount + spotLightCount);
    gl_FragColor = col * lightColor;
}
