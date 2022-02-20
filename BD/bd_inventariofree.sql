-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-02-2022 a las 18:51:22
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_inventariofree`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `NUEVO_PRODUCTO` (`CODIGO` VARCHAR(10))  INSERT INTO inventario (inv_pro_codigo) VALUES (CODIGO)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE `entrada` (
  `ent_id` int(4) NOT NULL,
  `ent_nombre` varchar(30) NOT NULL,
  `ent_pro_codigo` varchar(10) NOT NULL,
  `ent_fecha` date NOT NULL,
  `ent_cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`ent_id`, `ent_nombre`, `ent_pro_codigo`, `ent_fecha`, `ent_cantidad`) VALUES
(9, 'Alejandro', 'P285-USA', '2022-01-19', 2),
(10, 'Alejandro', 'P279-USA', '2022-01-19', 3),
(11, 'Alejandro', 'P285-USA', '2022-01-19', 1),
(12, 'Fernando', 'P285-USA', '2022-01-18', 1),
(13, 'Alejandro', 'P285-USA', '2022-01-13', 2),
(14, 'zxcsxcxzc', 'P285-USA', '2022-01-19', 2),
(15, 'Fernando', 'P279-USA', '2022-01-19', 5),
(16, 'Fernando', 'P285-USA', '2022-01-19', 2),
(19, 'Alejandro', 'P285-USA', '2022-01-19', 1),
(20, 'Fernando', 'P285-USA', '2022-01-19', 2),
(21, 'Fernando', 'P279-USA', '2022-01-19', 10),
(33, 'Alejandro', 'P285-USA', '2022-02-10', 3),
(34, 'Fernando', 'P285-USA', '2022-02-10', 4),
(35, 'Alejandro', 'P285-USA', '2022-02-11', 1),
(36, 'Fernando', 'WC001', '2022-02-10', 2),
(37, 'Fernando', 'WC001', '2022-02-10', 5),
(38, 'Fernando', 'WC001', '2022-02-11', 2),
(39, 'Fernando', 'WC001', '2022-02-09', 10),
(40, 'Fernando', 'P285-USA', '2022-02-11', 2),
(41, 'Fernando', 'WC001', '2022-02-11', 1),
(43, 'Fernando', 'WC001', '2022-02-10', 1);

--
-- Disparadores `entrada`
--
DELIMITER $$
CREATE TRIGGER `INVENTARIO_AI` AFTER INSERT ON `entrada` FOR EACH ROW UPDATE inventario SET inv_stock = inv_stock+NEW.ent_cantidad, inv_entradas = inv_entradas+NEW.ent_cantidad where inv_pro_codigo = NEW.ent_pro_codigo
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `inv_pro_codigo` varchar(10) NOT NULL,
  `inv_entradas` int(4) DEFAULT 0,
  `inv_salidas` int(4) DEFAULT 0,
  `inv_stock` int(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`inv_pro_codigo`, `inv_entradas`, `inv_salidas`, `inv_stock`) VALUES
('P279-USA', 20, 6, 14),
('P285-USA', 23, 4, 19),
('WC001', 21, 20, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `pro_codigo` varchar(10) NOT NULL,
  `pro_descripcion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`pro_codigo`, `pro_descripcion`) VALUES
('P279-USA', 'Piston 279mm EEUU'),
('P285-USA', 'Piston 285mm maquina EEUU'),
('WC001', 'Warner Clutch para beam 3 maquina BU');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE `salida` (
  `sal_id` int(4) NOT NULL,
  `sal_pro_codigo` varchar(10) DEFAULT NULL,
  `sal_tecnico` varchar(30) DEFAULT NULL,
  `sal_fecha` date NOT NULL,
  `maquina` varchar(11) NOT NULL,
  `sal_cantidad` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `salida`
--

INSERT INTO `salida` (`sal_id`, `sal_pro_codigo`, `sal_tecnico`, `sal_fecha`, `maquina`, `sal_cantidad`) VALUES
(8, 'P285-USA', 'Alejandro', '2022-02-12', '1', 1),
(9, 'WC001', 'Fernando', '2022-02-12', '7', 1),
(10, 'P285-USA', 'Alejandro', '2022-02-12', '1', 2),
(11, 'P279-USA', 'Fernando', '2022-02-12', '1', 1),
(12, 'P279-USA', 'Alejandro', '2022-02-17', '2', 1),
(13, 'P279-USA', 'Fernando', '2022-02-16', '11', 2),
(14, 'P279-USA', 'Fernando', '2022-02-17', '1', 1);

--
-- Disparadores `salida`
--
DELIMITER $$
CREATE TRIGGER `INVENTARIO_S_AI` AFTER INSERT ON `salida` FOR EACH ROW UPDATE inventario SET inv_stock = inv_stock-NEW.sal_cantidad, inv_salidas = inv_salidas+NEW.sal_cantidad where inv_pro_codigo = NEW.sal_pro_codigo
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicos`
--

CREATE TABLE `tecnicos` (
  `idtecnicos` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `badge` varchar(45) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `rol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tecnicos`
--

INSERT INTO `tecnicos` (`idtecnicos`, `nombre`, `badge`, `pass`, `rol`) VALUES
(1, 'Fernando', '61999', '123', 'admin'),
(2, 'Alejandro', '62000', '123', 'user');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD PRIMARY KEY (`ent_id`),
  ADD KEY `ent_pro_codigo` (`ent_pro_codigo`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`inv_pro_codigo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`pro_codigo`);

--
-- Indices de la tabla `salida`
--
ALTER TABLE `salida`
  ADD PRIMARY KEY (`sal_id`),
  ADD KEY `sal_pro_codigo` (`sal_pro_codigo`);

--
-- Indices de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`idtecnicos`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `entrada`
--
ALTER TABLE `entrada`
  MODIFY `ent_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `salida`
--
ALTER TABLE `salida`
  MODIFY `sal_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `idtecnicos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `entrada_ibfk_1` FOREIGN KEY (`ent_pro_codigo`) REFERENCES `producto` (`pro_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`inv_pro_codigo`) REFERENCES `producto` (`pro_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `salida`
--
ALTER TABLE `salida`
  ADD CONSTRAINT `salida_ibfk_1` FOREIGN KEY (`sal_pro_codigo`) REFERENCES `producto` (`pro_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
