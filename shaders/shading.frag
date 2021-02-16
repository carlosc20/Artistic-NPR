#version 330

in vec3 vNormal;
in vec3 vLightDir;

out vec4 colorOut;

void main()
{	
    vec4 diffuse = vec4(1.0, 0.0, 0.0, 1.0);

	vec3 n = normalize(vNormal);

	float intensity = max(dot(vLightDir,n),0.0);
	
	if (intensity > 0.90)
		colorOut = diffuse;
	else if (intensity > 0.75)
		colorOut = 0.75 * diffuse;
	else if (intensity > 0.5)
		colorOut = 0.5 * diffuse;
	else if (intensity > 0.25)
		colorOut = 0.25 * diffuse;
	else
		colorOut = 0.1 * diffuse;
}
