const path = require( 'path' );

const puppeteer = require( 'puppeteer' );

const USAGE = 'node make_pdf.js <input html> <output pdf filename>';

const printUsage = () => {
    console.error( USAGE );
};

( async () => {
    if( process.argv.length !== 4 ) {
        printUsage();
        process.exit( 1 );
    }

    const input_file = 'file://' + path.resolve( __dirname, process.argv[ 2 ] );
    const output_file = path.resolve( __dirname, process.argv[ 3 ] );

    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page
        .goto( input_file, {
            waitUntil: 'networkidle2' 
        } );

    await page
        .pdf( { 
            path: output_file, 
            // format: 'letter',
            width: '8.5in',
            printBackground: true,
            // TODO: Figure out how to not have a random scale factor here
            // scale: 0.86,
            scale: 1,
            margin: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            } 
        } );

    await browser.close();
} )()
    .then( () => {
        process.exit( 0 );
    } )
    .catch( ( err ) => {
        console.error( err );
        process.exit( 1 );
    } );
