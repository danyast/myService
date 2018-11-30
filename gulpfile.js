const gulp = require('gulp');
const sass = require('gulp-sass');
const autoprefixer = require('gulp-autoprefixer');
const browserSync = require('browser-sync');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const cssnano = require('gulp-cssnano');
const rename = require('gulp-rename');
const del = require('del');
const imagemin = require('gulp-imagemin');
const pngquant = require('imagemin-pngquant');
const cache = require('gulp-cache');

function CompileSass(){
	return gulp.src('src/scss/**/*+(sass|scss)')
		.pipe(sass())
		.pipe(autoprefixer({
			browsers: ['last 15 versions', '> 0.1%', 'ie 8', 'ie 7'],
			cascade: false
		}))
        .pipe(cssnano())
        .pipe(rename({suffix: '.min'}))
		.pipe(gulp.dest('src/css'))
		.pipe(browserSync.stream());
}

function imageMin() {
	return gulp.src('src/img/**/*')
		.pipe(cache(imagemin({
            interlaced: true,
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()]
		})))
		.pipe(gulp.dest('dist/img'));
}
 
function jquery() {
	return gulp.src('src/libs/jquery/dist/jquery.min.js')
		.pipe(gulp.dest('src/js'));
}

function reload(done){
	browserSync.reload();
	done();
}

function watch(){
	browserSync({
		server:{
			baseDir: 'src'
		},
		notify: false
	});
	gulp.watch('src/scss/**/*.+(sass|scss)', CompileSass);
	gulp.watch('src/*.html', reload);
	gulp.watch('src/js/*.js', reload);
}

function builder(done){
	  gulp.src('src/css/**/*')
		  .pipe(gulp.dest('dist/css'));
	  gulp.src('src/fonts/**/*')
		  .pipe(gulp.dest('dist/fonts'));
	  gulp.src('src/js/**/*')
		  .pipe(gulp.dest('dist/js'));
	  gulp.src('src/*.html')
		  .pipe(gulp.dest('dist'));
	  done();
}

function clean(){
	return del(['dist/*']);
}

gulp.task('sass', CompileSass);
gulp.task('jquery', jquery);
gulp.task('build', gulp.series(clean, gulp.parallel(CompileSass, imageMin), builder));
gulp.task('default', watch);
