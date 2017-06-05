'use strict';

var gulp = require('gulp');
var vapor = require('gulp-vapor');

vapor.config.commands.build = 'vapor build'; // #1

gulp.task('vapor:start', vapor.start);
gulp.task('vapor:reload', vapor.reload);

gulp.task('watch', function() {
    // #2
    var target = [
        './Sources/**/*',
        './Resources/**/*'
    ];
    gulp.watch(target, ['vapor:reload']);
});

gulp.task('default', ['vapor:start', 'watch']);
