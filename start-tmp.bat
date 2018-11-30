(
ECHO {
ECHO   "name": "gulp4",
ECHO   "version": "1.0.0",
ECHO   "main": "index.js",
ECHO   "dependencies": {},
ECHO   "devDependencies": {
ECHO     "browser-sync": "^2.26.3",
ECHO     "del": "^3.0.0",
ECHO     "gulp": "^4.0.0",
ECHO     "gulp-autoprefixer": "^6.0.0",
ECHO     "gulp-cache": "^1.0.2",
ECHO     "gulp-concat": "^2.6.1",
ECHO     "gulp-cssnano": "^2.1.3",
ECHO     "gulp-imagemin": "^5.0.3",
ECHO     "gulp-rename": "^1.4.0",
ECHO     "gulp-sass": "^4.0.2",
ECHO     "gulp-uglify": "^3.0.1",
ECHO     "imagemin-pngquant": "^6.0.0"
ECHO   },
ECHO   "scripts": {
ECHO     "test": "echo \"Error: no test specified\" && exit 1"
ECHO   },
ECHO   "keywords": [],
ECHO   "author": "",
ECHO   "license": "ISC",
ECHO   "description": ""
ECHO }
) >> package.json

(
ECHO const gulp ^= require^('gulp'^);
ECHO const sass ^= require^('gulp-sass'^);
ECHO const autoprefixer ^= require^('gulp-autoprefixer'^);
ECHO const browserSync ^= require^('browser-sync'^);
ECHO const concat ^= require^('gulp-concat'^);
ECHO const uglify ^= require^('gulp-uglify'^);
ECHO const cssnano ^= require^('gulp-cssnano'^);
ECHO const rename ^= require^('gulp-rename'^);
ECHO const del ^= require^('del'^);
ECHO const imagemin ^= require^('gulp-imagemin'^);
ECHO const pngquant ^= require^('imagemin-pngquant'^);
ECHO const cache ^= require^('gulp-cache'^);
ECHO.
ECHO function CompileSass^(^){
ECHO 	return gulp.src^('src/scss/^*^*/^*^+^(sass^|scss^)'^)
ECHO 		.pipe^(sass^(^)^)
ECHO 		.pipe^(autoprefixer^({
ECHO 			browsers: ['last 15 versions', '^> 0.1%%', 'ie 8', 'ie 7'],
ECHO 			cascade: false
ECHO 		}^)^)
ECHO         .pipe^(cssnano^(^)^)
ECHO         .pipe^(rename^({suffix: '.min'}^)^)
ECHO 		.pipe^(gulp.dest^('src/css'^)^)
ECHO 		.pipe^(browserSync.stream^(^)^);
ECHO }
ECHO.
ECHO function imageMin^(^) {
ECHO 	return gulp.src^('src/img/^*^*/^*'^)
ECHO 		.pipe^(cache^(imagemin^({
ECHO             interlaced: true,
ECHO             progressive: true,
ECHO             svgoPlugins: [{removeViewBox: false}],
ECHO             use: [pngquant^(^)]
ECHO 		}^)^)^)
ECHO 		.pipe^(gulp.dest^('dist/img'^)^);
ECHO }
ECHO. 
ECHO function jquery^(^) {
ECHO 	return gulp.src^('src/libs/jquery/dist/jquery.min.js'^)
ECHO 		.pipe^(gulp.dest^('src/js'^)^);
ECHO }
ECHO.
ECHO function reload^(done^){
ECHO 	browserSync.reload^(^);
ECHO 	done^(^);
ECHO }
ECHO.
ECHO function watch^(^){
ECHO 	browserSync^({
ECHO 		server:{
ECHO 			baseDir: 'src'
ECHO 		},
ECHO 		notify: false
ECHO 	}^);
ECHO 	gulp.watch^('src/scss/^*^*/^*.^+^(sass^|scss^)', CompileSass^);
ECHO 	gulp.watch^('src/^*.html', reload^);
ECHO 	gulp.watch^('src/js/^*.js', reload^);
ECHO }
ECHO.
ECHO function builder^(done^){
ECHO 	  gulp.src^('src/css/^*^*/^*'^)
ECHO 		  .pipe^(gulp.dest^('dist/css'^)^);
ECHO 	  gulp.src^('src/fonts/^*^*/^*'^)
ECHO 		  .pipe^(gulp.dest^('dist/fonts'^)^);
ECHO 	  gulp.src^('src/js/^*^*/^*'^)
ECHO 		  .pipe^(gulp.dest^('dist/js'^)^);
ECHO 	  gulp.src^('src/^*.html'^)
ECHO 		  .pipe^(gulp.dest^('dist'^)^);
ECHO 	  done^(^);
ECHO }
ECHO.
ECHO function clean^(^){
ECHO 	return del^(['dist/^*']^);
ECHO }
ECHO.
ECHO gulp.task^('sass', CompileSass^);
ECHO gulp.task^('jquery', jquery^);
ECHO gulp.task^('build', gulp.series^(clean, gulp.parallel^(CompileSass, imageMin^), builder^)^);
ECHO gulp.task^('default', watch^);
) >> gulpfile.js

(
ECHO /node_modules/
ECHO /.idea/
ECHO /dist/
ECHO /src/css/
ECHO /.git/
ECHO \\/^*^*/^*.psd
ECHO /^*^*/package-lock.json
ECHO /^*^*/Thumbs.db
ECHO /^*^*/.DS_Store
) >> .gitignore

(
ECHO {
ECHO   "directory" : "src/libs/"
ECHO }
) >> .bowerrc

MD src
CD /d src
MD css, fonts, img, js, scss

(
ECHO ^<!doctype html^>
ECHO ^<html lang="en"^> 
ECHO ^<head^>
ECHO     ^<meta charset="UTF-8"^>
ECHO     ^<meta name="viewport"
ECHO           content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"^>
ECHO     ^<meta http-equiv="X-UA-Compatible" content="ie=edge"^>
ECHO     ^<title^>Document^</title^>
ECHO     ^<link rel="stylesheet" href="css/bootstrap-grid.min.css"^>
ECHO     ^<link rel="stylesheet" href="css/main.min.css"^>
ECHO ^</head^>
ECHO ^<body^>
ECHO ^<script src="js/jquery.min.js"^>^</script^>
ECHO ^</body^>
ECHO ^</html^>
) >> index.html

CD /d scss

ECHO > main.scss
ECHO > _variables.scss
ECHO > _mixins.scss
ECHO > _media.scss
ECHO > _fonts.scss