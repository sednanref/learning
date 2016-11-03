var gulp = require('gulp');
var browserify = require('browserify');
var reactify = require('reactify');
var source = require('vinyl-source-stream');

var config = {
  entry_file: './source/client.js',
  destination_folder: './build/',
  destination_file: 'bundle.js'
};

gulp.task('build', function() {
  browserify(config.entry_file)
    .transform(reactify)
    .bundle()
    .on('error', console.error.bind(console))
    .pipe(source(config.destination_file))
    .pipe(gulp.dest(config.destination_folder));
});
