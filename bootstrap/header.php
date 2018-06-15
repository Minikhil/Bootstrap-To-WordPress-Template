<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <?php wp_head(); ?>

    <!-- Bootstrap core CSS -->
    <!-- <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->

    <!-- Custom styles for this template -->
    <!-- <link href="css/freelancer.min.css" rel="stylesheet"> -->

    <!-- Plugin CSS -->
    <!-- <link href="vendor/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css"> -->

    <!-- Custom fonts for this template -->
    <!-- <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">





  </head>

  <body id="page-top" <?php body_class(); ?>>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#index.php">SUB BOARD I, INC</a>
        <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <?php
            $defaults = array(
              'container'=> 'ul',
              'theme_location'=> 'primary-menu',
              'menu_class'=> 'navbar-nav ml-auto'
            );
            wp_nav_menu( $defaults);
           ?>


          <ul class="navbar-nav ml-auto">

            <li class="nav-item mx-0 mx-lg-1">
              <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio">SERVICES</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
