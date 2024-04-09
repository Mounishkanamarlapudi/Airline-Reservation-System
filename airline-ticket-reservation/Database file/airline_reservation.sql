-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: NOV 05, 2023 at 10:30 AM
-- Server version: 5.6.21
-- PHP Version: 5.5.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `airline_reservation`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`Mounish`@`localhost` PROCEDURE `GetFlightStatistics`(IN `j_date` DATE)
BEGIN
 select flight_no,departure_date,IFNULL(no_of_passengers, 0) as no_of_passengers,total_capacity from (
select f.flight_no,f.departure_date,sum(t.no_of_passengers) as no_of_passengers,j.total_capacity 
from flight_details f left join ticket_details t 
on t.booking_status='CONFIRMED' 
and t.flight_no=f.flight_no 
and f.departure_date=t.journey_date 
inner join jet_details j on j.jet_id=f.jet_id
group by flight_no,journey_date) k where departure_date=j_date;
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` varchar(20) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `staff_id` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `pwd`, `staff_id`, `name`, `email`) VALUES
('admin', 'Mounish@9', 'admin', 'Mounish', 'mounish.kanamarlapudi9@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` varchar(20) NOT NULL,
  `pwd` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `address` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `pwd`, `name`, `email`, `phone_no`, `address`) VALUES
('Mounish', 'Mounish@9', 'Naga Sai Mounish.K', 'mounish.kanamarlapudi9@gmail.com', '8985514578', 'chilakaluripet'),
('kotesh', 'Kotesh@120', 'Kotesh', 'kotesh@gmail.com', '9876543210', 'srikakulam'),
('persis', 'Persis@125', 'Persis', 'Persis@gmail.com', '9876543211', 'guntur'),
('valli', 'Valli@144', 'Sri Valli', 'valli@gmail.com', '9876543212', 'vijaywada'),


-- --------------------------------------------------------

--
-- Table structure for table `flight_details`
--

CREATE TABLE IF NOT EXISTS `flight_details` (
  `flight_no` varchar(10) NOT NULL,
  `from_city` varchar(20) DEFAULT NULL,
  `to_city` varchar(20) DEFAULT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `seats_economy` int(5) DEFAULT NULL,
  `seats_business` int(5) DEFAULT NULL,
  `price_economy` int(10) DEFAULT NULL,
  `price_business` int(10) DEFAULT NULL,
  `jet_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flight_details`
--

INSERT INTO `flight_details` (`flight_no`, `from_city`, `to_city`, `departure_date`, `arrival_date`, `departure_time`, `arrival_time`, `seats_economy`, `seats_business`, `price_economy`, `price_business`, `jet_id`) VALUES
('PS101', 'Guntur', 'Mumbai', '2023-11-16', '2023-11-17', '21:00:00', '01:00:00', 195, 96, 5000, 7500, '10001'),
('PS102', 'Guntur', 'Chennai', '2023-11-16', '2023-11-16', '10:00:00', '12:00:00', 200, 73, 2500, 3000, '10002'),
('PS103', 'Guntur', 'Mysore', '2023-11-17', '2017-11-17', '17:00:00', '19:45:00', 150, 75, 1200, 1500, '10003'),
('PS104', 'Guntur', 'Hyderabad', '2023-11-17', '2023-11-17', '09:00:00', '09:17:00', 37, 4, 500, 750, '10004'),
('PS105', 'Guntur', 'Banglore', '2023-11-18', '2023-11-18', '13:00:00', '17:00:00', 150, 75, 3000, 3750, '10005'),


-- --------------------------------------------------------

--
-- Table structure for table `frequent_flier_details`
--

CREATE TABLE IF NOT EXISTS `frequent_flier_details` (
  `frequent_flier_no` varchar(20) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `mileage` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `frequent_flier_details`
--

INSERT INTO `frequent_flier_details` (`frequent_flier_no`, `customer_id`, `mileage`) VALUES
('10001000', 'Persis', 375),
('20002000', 'Valli', 150);

-- --------------------------------------------------------

--
-- Table structure for table `jet_details`
--

CREATE TABLE IF NOT EXISTS `jet_details` (
  `jet_id` varchar(10) NOT NULL,
  `jet_type` varchar(20) DEFAULT NULL,
  `total_capacity` int(5) DEFAULT NULL,
  `active` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jet_details`
--

INSERT INTO `jet_details` (`jet_id`, `jet_type`, `total_capacity`, `active`) VALUES
('10001', 'Dreamliner', 300, 'Yes'),
('10002', 'Airbus A380', 275, 'Yes'),
('10003', 'ATR', 50, 'Yes'),
('10004', 'Boeing 737', 225, 'Yes'),
('10005', 'Test_Model', 250, 'Yes'),

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE IF NOT EXISTS `passengers` (
  `passenger_id` int(10) NOT NULL,
  `pnr` varchar(15) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `meal_choice` varchar(5) DEFAULT NULL,
  `frequent_flier_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`passenger_id`, `pnr`, `name`, `age`, `gender`, `meal_choice`, `frequent_flier_no`) VALUES
(1, '1669050', 'Harry Roshan', 20, 'male', 'yes', '20002000'),
(1, '2033264', 'RAKHI', 25, 'female', 'yes', NULL),
(1, '2179656', 'KIMI', 11, 'male', 'yes', NULL),
(1, '2369143', 'blah', 20, 'male', 'yes', NULL),
(1, '3027167', 'aadith_name', 10, 'male', 'yes', NULL),
(1, '3773951', 'harry', 51, 'male', 'yes', NULL),
(1, '3817993', 'SANCHIT KUMAR', 23, 'male', 'yes', NULL),
(1, '4797983', 'pass1', 34, 'male', 'yes', NULL),
(1, '4807312', 'SANCHIT', 22, 'male', 'yes', NULL),
(1, '5272308', 'SHUBHANGI SINGH', 1, 'female', 'yes', NULL),
(1, '5421865', 'pass1', 10, 'male', 'yes', NULL),
(1, '6980157', 'roshan', 20, 'male', 'yes', NULL),
(1, '8503285', 'aadith_name', 10, 'male', 'yes', '10001000'),
(1, '9288360', 'SANCHIT KUMAR', 23, 'male', 'yes', NULL),
(2, '1669050', 'berti harry', 45, 'female', 'yes', NULL),
(2, '2369143', 'blah', 51, 'male', 'yes', NULL),
(2, '3027167', 'roshan', 20, 'male', 'yes', NULL),
(2, '3773951', 'berti', 42, 'female', 'yes', NULL),
(2, '3817993', 'RANJIT KUMAR', 26, 'male', 'yes', NULL),
(2, '4797983', 'Harry Roshan', 20, 'male', 'yes', '20002000'),
(2, '4807312', 'RANJIT', 66, 'male', 'yes', NULL),
(2, '5421865', 'pass2', 20, 'female', 'yes', NULL),
(2, '6980157', 'aadith', 9, 'male', 'yes', NULL),
(2, '8503285', 'roshan_name', 20, 'male', 'yes', NULL),
(2, '9288360', 'SHUBHAM KUMAR', 24, 'male', 'yes', NULL),
(3, '1669050', 'aadith_name', 10, 'male', 'yes', NULL),
(3, '2369143', 'blah', 10, 'male', 'yes', NULL),
(3, '3773951', 'aadith', 11, 'male', 'yes', '10001000'),
(3, '4797983', 'aadith_name', 10, 'male', 'yes', '10001000'),
(3, '4807312', 'SURESH', 22, 'male', 'yes', NULL),
(3, '5421865', 'pass3', 30, 'male', 'yes', NULL),
(4, '2369143', 'blah', 42, 'female', 'yes', NULL),
(4, '4807312', 'RAMESH', 65, 'male', 'yes', NULL),
(5, '4807312', 'SHYAMA', 22, 'female', 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE IF NOT EXISTS `payment_details` (
  `payment_id` varchar(20) NOT NULL,
  `pnr` varchar(15) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount` int(6) DEFAULT NULL,
  `payment_mode` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`payment_id`, `pnr`, `payment_date`, `payment_amount`, `payment_mode`) VALUES
('120000248', '4797983', '2023-11-25', 4200, 'credit card'),
('142539461', '3773951', '2023-11-25', 4050, 'credit card'),
('165125569', '8503285', '2023-11-25', 7500, 'net banking'),
('423519897', '2033264', '2023-08-17', 6638, 'credit card'),
('460571289', '9572357', '2023-08-19', 25700, 'debit card'),
('467972527', '2369143', '2023-11-26', 33400, 'debit card'),
('557778944', '6980157', '2023-11-26', 11700, 'credit card'),
('620041544', '1669050', '2023-11-25', 4800, 'debit card'),
('665360715', '5421865', '2023-11-28', 15750, 'net banking'),
('679391479', '4807312', '2023-08-17', 26865, 'credit card'),
('723941040', '3817993', '2023-08-17', 19004, 'net banking'),
('757064819', '2538635', '2023-08-17', 4773, 'debit card'),
('862686553', '3027167', '2023-11-25', 10700, 'debit card'),
('880633544', '9288360', '2023-08-19', 25700, 'debit card'),
('936389160', '2179656', '2023-08-17', 6638, 'credit card'),
('952539062', '5272308', '2023-08-18', 7850, 'credit card');

--
-- Triggers `payment_details`
--
DELIMITER //
CREATE TRIGGER `update_ticket_after_payment` AFTER INSERT ON `payment_details`
 FOR EACH ROW UPDATE ticket_details
     SET booking_status='CONFIRMED', payment_id= NEW.payment_id
   WHERE pnr = NEW.pnr
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_details`
--

CREATE TABLE IF NOT EXISTS `ticket_details` (
  `pnr` varchar(15) NOT NULL,
  `date_of_reservation` date DEFAULT NULL,
  `flight_no` varchar(10) DEFAULT NULL,
  `journey_date` date DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `booking_status` varchar(20) DEFAULT NULL,
  `no_of_passengers` int(5) DEFAULT NULL,
  `lounge_access` varchar(5) DEFAULT NULL,
  `priority_checkin` varchar(5) DEFAULT NULL,
  `insurance` varchar(5) DEFAULT NULL,
  `payment_id` varchar(20) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket_details`
--

INSERT INTO `ticket_details` (`pnr`, `date_of_reservation`, `flight_no`, `journey_date`, `class`, `booking_status`, `no_of_passengers`, `lounge_access`, `priority_checkin`, `insurance`, `payment_id`, `customer_id`) VALUES
('1669050', '2017-11-25', 'AA104', '2017-12-04', 'business', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '620041544', 'harryroshan'),
('2033264', '2019-08-17', 'AIRBUS70PA', '2019-08-19', 'economy', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '423519897', 'SANCHIT'),
('2179656', '2019-08-17', 'AIRBUS70PA', '2019-08-19', 'economy', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '936389160', 'KUMAR'),
('2369143', '2017-11-26', 'AA101', '2017-12-01', 'business', 'CONFIRMED', 4, 'yes', 'yes', 'yes', '467972527', 'blah'),
('2538635', '2019-08-17', 'AIRBUS70BA', '2019-08-19', 'economy', 'CANCELED', 1, 'no', 'no', 'no', '757064819', 'SANCHIT'),
('2709472', '2019-08-18', NULL, NULL, NULL, 'PENDING', NULL, NULL, NULL, NULL, NULL, NULL),
('3027167', '2017-11-25', 'AA101', '2017-12-01', 'economy', 'CONFIRMED', 2, 'no', 'no', 'yes', '862686553', 'aadith'),
('3773951', '2017-11-25', 'AA104', '2017-12-04', 'economy', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '142539461', 'aadith'),
('3817993', '2019-08-17', 'AIRBUS70BA', '2019-08-19', 'business', 'CONFIRMED', 2, 'yes', 'yes', 'yes', '723941040', 'SANCHIT'),
('4797983', '2017-11-25', 'AA104', '2017-12-04', 'business', 'CONFIRMED', 3, 'yes', 'no', 'yes', '120000248', 'harryroshan'),
('4807312', '2019-08-17', 'AIRBUS70BA', '2019-08-19', 'economy', 'CANCELED', 5, 'yes', 'yes', 'yes', '679391479', 'SANCHIT'),
('5272308', '2019-08-18', 'BOING707PA', '2019-08-25', 'business', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '952539062', 'SANCHIT'),
('5421865', '2017-11-28', 'AA101', '2017-12-01', 'economy', 'CONFIRMED', 3, 'no', 'no', 'no', '665360715', 'harryroshan'),
('6980157', '2017-11-26', 'AA101', '2017-12-01', 'economy', 'CANCELED', 2, 'yes', 'yes', 'yes', '557778944', 'aadith'),
('8503285', '2017-11-25', 'AA102', '2017-12-01', 'business', 'CONFIRMED', 2, 'yes', 'yes', 'no', '165125569', 'aadith'),
('9288360', '2019-08-19', 'AIR707MXPA', '2019-09-01', 'business', 'CONFIRMED', 2, 'yes', 'yes', 'yes', '880633544', 'SANCHIT'),
('9572357', '2019-08-19', 'AIR707MXPA', '2019-09-01', 'business', 'CANCELED', 2, 'yes', 'yes', 'yes', '460571289', 'SANCHIT');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
 ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
 ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `flight_details`
--
ALTER TABLE `flight_details`
 ADD PRIMARY KEY (`flight_no`,`departure_date`), ADD KEY `jet_id` (`jet_id`);

--
-- Indexes for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
 ADD PRIMARY KEY (`frequent_flier_no`), ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `jet_details`
--
ALTER TABLE `jet_details`
 ADD PRIMARY KEY (`jet_id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
 ADD PRIMARY KEY (`passenger_id`,`pnr`), ADD KEY `pnr` (`pnr`), ADD KEY `frequent_flier_no` (`frequent_flier_no`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
 ADD PRIMARY KEY (`payment_id`), ADD KEY `pnr` (`pnr`);

--
-- Indexes for table `ticket_details`
--
ALTER TABLE `ticket_details`
 ADD PRIMARY KEY (`pnr`), ADD KEY `customer_id` (`customer_id`), ADD KEY `journey_date` (`journey_date`), ADD KEY `flight_no` (`flight_no`), ADD KEY `flight_no_2` (`flight_no`,`journey_date`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight_details`
--
ALTER TABLE `flight_details`
ADD CONSTRAINT `flight_details_ibfk_1` FOREIGN KEY (`jet_id`) REFERENCES `jet_details` (`jet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
ADD CONSTRAINT `frequent_flier_details_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
ADD CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `passengers_ibfk_2` FOREIGN KEY (`frequent_flier_no`) REFERENCES `frequent_flier_details` (`frequent_flier_no`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_details`
--
ALTER TABLE `payment_details`
ADD CONSTRAINT `payment_details_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON UPDATE CASCADE;

--
-- Constraints for table `ticket_details`
--
ALTER TABLE `ticket_details`
ADD CONSTRAINT `ticket_details_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `ticket_details_ibfk_3` FOREIGN KEY (`flight_no`, `journey_date`) REFERENCES `flight_details` (`flight_no`, `departure_date`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
