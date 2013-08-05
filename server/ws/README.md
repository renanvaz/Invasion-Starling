# Kohana 3.3 extended

Features
---

- Template estruture with base, header, footer and content files.
- Auto return content view file from controller/action name.
- Manage assets anytime in Controller or View files (style sheets, images and javascript files).
- Compress, merge and minify CSS and JS files when env is set equal PRODUCTION.
- Image helper for resize, crop and cache images.
- Manage env mode and base url in .htaccess.

Estruture
---

In this extruture the module template (modules/template) is used for, organize views and assets.

	- media/ (extended extruture for assets)
		- css/
		- img/
			- upload/
		- js/
	+ application/ (kohana default estruture)
	+ modules/ (kohana default estruture)
	+ system/ (kohana default estruture)

