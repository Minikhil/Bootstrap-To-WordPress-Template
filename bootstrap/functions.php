<?php

add_theme_support('post-thumbnails'); //adds set featured image function for posts
add_theme_support('menus'); //adss feature to edit nav bar from WP admin
add_theme_support('editor');

function ab2w_register_theme_menus(){
  register_nav_menus(
    array('primary-menu' => ('Primary Menu'), )

  );
}

add_action('int', 'ab2w_register_theme_menus');

function ab2w_theme_styles(){

  wp_enqueue_style('bootstrap.min_css', get_template_directory_uri() . '/vendor/bootstrap/css/bootstrap.min.css');

  wp_enqueue_style('font-awesome.min_css', get_template_directory_uri() . '/vendor/font-awesome/css/font-awesome.min.css');

  wp_enqueue_style('magnific-popup_css', get_template_directory_uri() . '/vendor/magnific-popup/magnific-popup.css');

  wp_enqueue_style('freelancer.min_css', get_template_directory_uri() . '/style.css');
}

add_action('wp_enqueue_scripts', 'ab2w_theme_styles');

function ab2w_theme_js(){

  wp_enqueue_script('bootstrap_js', get_template_directory_uri() . '/vendor/bootstrap/js/bootstrap.bundle.min.js');

  wp_enqueue_script('easing_js', get_template_directory_uri() . '/vendor/jquery-easing/jquery.easing.min.js');

  wp_enqueue_script('magnific-popup_js', get_template_directory_uri() . '/vendor/magnific-popup/jquery.magnific-popup.min.js');

  wp_enqueue_script('jqBootstrapValidation_js', get_template_directory_uri() . '/js/jqBootstrapValidation.js');

  wp_enqueue_script('contact_me_js', get_template_directory_uri() . '/js/contact_me.js');

  wp_enqueue_script('freelancer_js', get_template_directory_uri() . '/js/freelancer.min.js');

}

add_action('wp_enqueue_scripts', 'ab2ab2w_theme_js');







 ?>
