#version 330

in vec2 pass_textureCoords;

out vec4 out_colour;

uniform vec3 colour;
uniform sampler2D fontAtlas;

uniform float width;        // = 0.5;
uniform float edge;         // = 0.1;
//effects
uniform float borderWidth;  // = 0.5; //0 to text without effects
uniform float borderEdge;   // = 0.4;

// drop shadow effect
uniform vec2 offset;        // = vec2(0.006, 0.006); //0.0, 0.0 to text without effects

uniform vec3 outlineColour; // = vec3(0.2, 0.2, 0.2);

void main(void){

    float distance = 1.0 - texture(fontAtlas, pass_textureCoords).a;
    float alpha = 1.0 - smoothstep(width, width + edge, distance);
    //effects
    float distance2 = 1.0 - texture(fontAtlas, pass_textureCoords + offset).a;
    float outlineAlpha = 1.0 - smoothstep(borderWidth, borderWidth + borderEdge, distance2);
    //end
    
    float overallAlpha = alpha + (1.0 - alpha) * outlineAlpha;
    vec3 overallColour = mix(outlineColour, colour, alpha / overallAlpha);
    
	out_colour = vec4(overallColour, overallAlpha);

}