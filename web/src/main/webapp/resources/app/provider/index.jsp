<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Виконавець послуг</title>

    <link href="/resources/assets/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/resources/assets/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/assets/css/provider.css" rel="stylesheet">
</head>

<body>

<div id="providerModule" class="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0" ng-controller="TopNavBarController">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand">Централізована система повірки лічильників</a>
        </div>

        <!-- Nav bar top right links -->
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown" dropdown>
                <a class="dropdown-toggle" dropdown-toggle>
                    <i class="fa fa-user fa-fw"></i><i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a><i class="fa fa-user fa-fw"></i> Профіль</a>
                    </li>
                    <li><a><i class="fa fa-gear fa-fw"></i> Налаштування</a>
                    </li>
                    <li class="divider"></li>
                    <li><a ng-click="logout()"><i class="fa fa-sign-out fa-fw"></i> Вийти</a>
                    </li>
                </ul>
            </li>
        </ul>

        <!-- Sidebar --> 
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li ui-sref-active="active">
                        <a ui-sref="main-panel"><i class="fa fa-home fa-fw"></i> Головна панель</a>
                    </li>

                    <li ui-sref-active="active">
                        <a ui-sref="new-verifications"><i class="fa fa-list-alt fa-fw"></i>Нові заявки</a>
                    </li>
	                <li ui-sref-active="active">
                        <a ui-sref="adding-verifications"><i class="fa fa-file-text-o"></i>Ініціювати повірку</a>
                    </li>
				<sec:authorize url="/provider/admin/">
                    <li ui-sref-active="active">
                        <a ui-sref="employees"><i class="fa fa-user-plus"></i>Додати працівника</a>
                    </li>
                    <li ui-sref-active="active">
                        <a ui-sref="employee-show"><i class="fa fa-users"></i>Переглянути усіх працівників</a>
                    </li>
                </sec:authorize>
                    <li ui-sref-active="active">
                        <a ui-sref="verifications-archive"><i class="fa fa-archive fa-fw"></i> Архів повірок</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div ui-view></div>

</div>

<script type="text/javascript" data-main="/resources/app/provider/runApp"
        src="/resources/assets/bower_components/requirejs/require.js"></script>
</body>
