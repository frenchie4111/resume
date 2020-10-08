var colors = [
    '#226A31',
    '#223e6a',
    '#59226a',
    '#6a2227',
    '#6a4622'
];
var current_color = 0;
var time_between_changes = 7000;

function changeColor( new_color ) {
    $( '.changing-color' ).attr( 'style', 'background-color: ' + new_color + ';color: ' + new_color + ';' );
}

function nextColor() {
    current_color ++;
    current_color %= colors.length;
    changeColor( colors[ current_color ] )
    setTimeout( nextColor, time_between_changes )
}

$( function() {
    // nextColor();
} );