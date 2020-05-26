// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"
import 'bootstrap';
import "../node_modules/jquery/dist/jquery.js";
import "../node_modules/bootstrap/dist/js/bootstrap.js";
import "../node_modules/masonry-layout/dist/masonry.pkgd.js";


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import './socket'
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

