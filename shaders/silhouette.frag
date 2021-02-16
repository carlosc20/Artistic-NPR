#version 330

// in
in vec3 gPosition; // Position in camera coords
in vec3 gNormal; // Normal in camera coords.
in vec3 gLightDir;
in float gDist;
flat in int gIsEdge; // Whether or not we're drawing an edge

// uniforms
uniform vec4 lineColor;
uniform float edgeWidth;

// out
out vec4 colorOut;


vec3 toonShade(){

	float intensity;
	vec3 l, n;
	
	n = normalize(gNormal);
	// no need to normalize the light direction!
	intensity = max(dot(gLightDir,n),0.0);
	
    vec3 diffuse = vec3(1.0, 0.0, 0.0);
    vec3 outputF = diffuse;

	if (intensity > 0.90)
		outputF = diffuse;
	else if (intensity > 0.75)
		outputF = 0.75 * diffuse;
	else if (intensity > 0.5)
		outputF = 0.5 * diffuse;
	else if (intensity > 0.25)
		outputF = 0.25 * diffuse;
	else
		outputF = 0.1 * diffuse;

    return outputF;
}

void main(){
    if(gIsEdge == 1){
        float alpha = 1.0;
        float d = abs(gDist); // distance from edge
        float tipLength = 2 * fwidth(d); // length of alpha gradient
        if (d > edgeWidth - tipLength)
            alpha = 1.0 - (d - edgeWidth + tipLength) / tipLength;

        colorOut = vec4(lineColor.xyz, alpha);
        //colorOut = lineColor;
    }
    else{
        colorOut = vec4(toonShade(), 1.0);
    }
}