-- MySQL dump 10.13  Distrib 8.4.4, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: wiki
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics`
--

LOCK TABLES `analytics` WRITE;
/*!40000 ALTER TABLE `analytics` DISABLE KEYS */;
INSERT INTO `analytics` VALUES ('azureinsights',0,'{\"instrumentationKey\": \"\"}'),('baidutongji',0,'{\"propertyTrackingId\": \"\"}'),('countly',0,'{\"appKey\": \"\", \"serverUrl\": \"\"}'),('elasticapm',0,'{\"serverUrl\": \"http://apm.example.com:8200\", \"environment\": \"\", \"serviceName\": \"wiki-js\"}'),('fathom',0,'{\"host\": \"\", \"siteId\": \"\"}'),('fullstory',0,'{\"org\": \"\"}'),('google',0,'{\"propertyTrackingId\": \"\"}'),('gtm',0,'{\"containerTrackingId\": \"\"}'),('hotjar',0,'{\"siteId\": \"\"}'),('matomo',0,'{\"siteId\": 1, \"serverHost\": \"https://example.matomo.cloud\"}'),('newrelic',0,'{\"appId\": \"\", \"beacon\": \"bam.nr-data.net\", \"licenseKey\": \"\", \"errorBeacon\": \"bam.nr-data.net\"}'),('plausible',0,'{\"domain\": \"\", \"plausibleJsSrc\": \"https://plausible.io/js/plausible.js\"}'),('statcounter',0,'{\"projectId\": \"\", \"securityToken\": \"\"}'),('umami',0,'{\"url\": \"\", \"websiteID\": \"\"}'),('umami2',0,'{\"url\": \"\", \"websiteID\": \"\"}'),('yandex',0,'{\"tagNumber\": \"\"}');
/*!40000 ALTER TABLE `analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apiKeys`
--

DROP TABLE IF EXISTS `apiKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apiKeys` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` text NOT NULL,
  `expiration` varchar(255) NOT NULL,
  `isRevoked` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apiKeys`
--

LOCK TABLES `apiKeys` WRITE;
/*!40000 ALTER TABLE `apiKeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `apiKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetData`
--

DROP TABLE IF EXISTS `assetData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assetData` (
  `id` int NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetData`
--

LOCK TABLES `assetData` WRITE;
/*!40000 ALTER TABLE `assetData` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetFolders`
--

DROP TABLE IF EXISTS `assetFolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assetFolders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `parentId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assetfolders_parentid_foreign` (`parentId`),
  CONSTRAINT `assetfolders_parentid_foreign` FOREIGN KEY (`parentId`) REFERENCES `assetFolders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetFolders`
--

LOCK TABLES `assetFolders` WRITE;
/*!40000 ALTER TABLE `assetFolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetFolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `ext` varchar(255) NOT NULL,
  `kind` enum('binary','image') NOT NULL DEFAULT 'binary',
  `mime` varchar(255) NOT NULL DEFAULT 'application/octet-stream',
  `fileSize` int unsigned DEFAULT NULL COMMENT 'In kilobytes',
  `metadata` json DEFAULT NULL,
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  `folderId` int unsigned DEFAULT NULL,
  `authorId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_folderid_foreign` (`folderId`),
  KEY `assets_authorid_foreign` (`authorId`),
  CONSTRAINT `assets_authorid_foreign` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`),
  CONSTRAINT `assets_folderid_foreign` FOREIGN KEY (`folderId`) REFERENCES `assetFolders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authentication`
--

DROP TABLE IF EXISTS `authentication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authentication` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json NOT NULL,
  `selfRegistration` tinyint(1) NOT NULL DEFAULT '0',
  `domainWhitelist` json NOT NULL,
  `autoEnrollGroups` json NOT NULL,
  `order` int unsigned NOT NULL DEFAULT '0',
  `strategyKey` varchar(255) NOT NULL DEFAULT '',
  `displayName` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication`
--

LOCK TABLES `authentication` WRITE;
/*!40000 ALTER TABLE `authentication` DISABLE KEYS */;
INSERT INTO `authentication` VALUES ('local',1,'{}',0,'{\"v\": []}','{\"v\": []}',0,'local','Local');
/*!40000 ALTER TABLE `authentication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brute`
--

DROP TABLE IF EXISTS `brute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brute` (
  `key` varchar(255) DEFAULT NULL,
  `firstRequest` bigint DEFAULT NULL,
  `lastRequest` bigint DEFAULT NULL,
  `lifetime` bigint DEFAULT NULL,
  `count` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brute`
--

LOCK TABLES `brute` WRITE;
/*!40000 ALTER TABLE `brute` DISABLE KEYS */;
/*!40000 ALTER TABLE `brute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentProviders`
--

DROP TABLE IF EXISTS `commentProviders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentProviders` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentProviders`
--

LOCK TABLES `commentProviders` WRITE;
/*!40000 ALTER TABLE `commentProviders` DISABLE KEYS */;
INSERT INTO `commentProviders` VALUES ('artalk',0,'{\"server\": \"\", \"siteName\": \"\"}'),('commento',0,'{\"instanceUrl\": \"https://cdn.commento.io\"}'),('default',1,'{\"akismet\": \"\", \"minDelay\": 30}'),('disqus',0,'{\"accountName\": \"\"}');
/*!40000 ALTER TABLE `commentProviders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  `pageId` int unsigned DEFAULT NULL,
  `authorId` int unsigned DEFAULT NULL,
  `render` text NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(255) NOT NULL DEFAULT '',
  `replyTo` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `comments_pageid_foreign` (`pageId`),
  KEY `comments_authorid_foreign` (`authorId`),
  CONSTRAINT `comments_authorid_foreign` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editors`
--

DROP TABLE IF EXISTS `editors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editors` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editors`
--

LOCK TABLES `editors` WRITE;
/*!40000 ALTER TABLE `editors` DISABLE KEYS */;
INSERT INTO `editors` VALUES ('api',0,'{}'),('asciidoc',0,'{}'),('ckeditor',0,'{}'),('code',0,'{}'),('markdown',1,'{}'),('redirect',0,'{}'),('wysiwyg',0,'{}');
/*!40000 ALTER TABLE `editors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `permissions` json NOT NULL,
  `pageRules` json NOT NULL,
  `isSystem` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  `redirectOnLogin` varchar(255) NOT NULL DEFAULT '/',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Administrators','[\"manage:system\"]','[]',1,'2025-04-18T01:27:15.645Z','2025-04-18T01:27:15.645Z','/'),(2,'Guests','[\"read:pages\", \"read:assets\", \"read:comments\"]','[{\"id\": \"guest\", \"deny\": false, \"path\": \"\", \"match\": \"START\", \"roles\": [\"read:pages\", \"read:assets\", \"read:comments\"], \"locales\": []}]',1,'2025-04-18T01:27:15.651Z','2025-04-18T01:27:15.651Z','/');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales`
--

DROP TABLE IF EXISTS `locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locales` (
  `code` varchar(5) NOT NULL,
  `strings` json DEFAULT NULL,
  `isRTL` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `nativeName` varchar(255) NOT NULL,
  `availability` int NOT NULL DEFAULT '0',
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales`
--

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;
INSERT INTO `locales` VALUES ('en','{\"auth\": {\"tfa\": {\"title\": \"Two Factor Authentication\", \"subtitle\": \"Security code required:\", \"placeholder\": \"XXXXXX\", \"verifyToken\": \"Verify\"}, \"errors\": {\"loginError\": \"Login error\", \"invalidLogin\": \"Invalid Login\", \"userNotFound\": \"User not found\", \"invalidLoginMsg\": \"The email or password is invalid.\", \"tooManyAttempts\": \"Too many attempts!\", \"invalidUserEmail\": \"Invalid User Email\", \"notYetAuthorized\": \"You have not been authorized to login to this site yet.\", \"tooManyAttemptsMsg\": \"You\'ve made too many failed attempts in a short period of time, please try again {{time}}.\"}, \"fields\": {\"name\": \"Name\", \"email\": \"Email Address\", \"password\": \"Password\", \"username\": \"Username\", \"emailUser\": \"Email / Username\", \"verifyPassword\": \"Verify Password\"}, \"actions\": {\"login\": \"Log In\", \"register\": \"Register\"}, \"changePwd\": {\"loading\": \"Changing password...\", \"proceed\": \"Change Password\", \"subtitle\": \"Choose a new password\", \"instructions\": \"You must choose a new password:\", \"newPasswordPlaceholder\": \"New Password\", \"newPasswordVerifyPlaceholder\": \"Verify New Password\"}, \"providers\": {\"ldap\": \"LDAP / Active Directory\", \"azure\": \"Azure Active Directory\", \"local\": \"Local\", \"slack\": \"Slack\", \"github\": \"GitHub\", \"google\": \"Google ID\", \"facebook\": \"Facebook\", \"windowslive\": \"Microsoft Account\"}, \"signingIn\": \"Signing In...\", \"pleaseWait\": \"Please wait\", \"missingName\": \"Name is missing.\", \"nameTooLong\": \"Name is too long.\", \"registering\": \"Creating account...\", \"genericError\": \"Authentication is unavailable.\", \"invalidEmail\": \"Email address is invalid.\", \"loginSuccess\": \"Login Successful! Redirecting...\", \"missingEmail\": \"Missing email address.\", \"nameTooShort\": \"Name is too short.\", \"tfaFormTitle\": \"Enter the security code generated from your trusted device:\", \"loginRequired\": \"Login required\", \"registerTitle\": \"Create an account\", \"switchToLogin\": {\"link\": \"Login instead\", \"text\": \"Already have an account? {{link}}\"}, \"tfaSetupTitle\": \"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.\", \"invalidPassword\": \"Enter a valid password.\", \"missingPassword\": \"Missing password.\", \"registerSuccess\": \"Account created successfully!\", \"enterCredentials\": \"Enter your credentials\", \"passwordNotMatch\": \"Both passwords do not match.\", \"passwordTooShort\": \"Password is too short.\", \"registerSubTitle\": \"Fill-in the form below to create your account.\", \"switchToRegister\": {\"link\": \"Create an account\", \"text\": \"Don\'t have an account yet? {{link}}\"}, \"sendResetPassword\": \"Reset Password\", \"forgotPasswordLink\": \"Forgot your password?\", \"loginUsingStrategy\": \"Login using {{strategy}}\", \"registerCheckEmail\": \"Check your emails to activate your account.\", \"selectAuthProvider\": \"Select Authentication Provider\", \"tfaSetupInstrFirst\": \"1) Scan the QR code below from your mobile 2FA application:\", \"forgotPasswordTitle\": \"Forgot your password\", \"tfaSetupInstrSecond\": \"2) Enter the security code generated from your trusted device:\", \"forgotPasswordCancel\": \"Cancel\", \"invalidEmailUsername\": \"Enter a valid email / username.\", \"orLoginUsingStrategy\": \"or login using...\", \"forgotPasswordLoading\": \"Requesting password reset...\", \"forgotPasswordSuccess\": \"Check your emails for password reset instructions!\", \"forgotPasswordSubtitle\": \"Enter your email address to receive the instructions to reset your password:\"}, \"tags\": {\"locale\": \"Locale\", \"orderBy\": \"Order By\", \"localeAny\": \"Any\", \"noResults\": \"Couldn\'t find any page with the selected tags.\", \"orderByField\": {\"ID\": \"ID\", \"path\": \"Path\", \"title\": \"Title\", \"creationDate\": \"Creation Date\", \"lastModified\": \"Last Modified\"}, \"clearSelection\": \"Clear Selection\", \"pageLastUpdated\": \"Last Updated {{date}}\", \"currentSelection\": \"Current Selection\", \"selectOneMoreTags\": \"Select one or more tags\", \"noResultsWithFilter\": \"Couldn\'t find any page matching the current filtering options.\", \"selectOneMoreTagsHint\": \"Select one or more tags on the left.\", \"retrievingResultsLoading\": \"Retrieving page results...\", \"searchWithinResultsPlaceholder\": \"Search within results...\"}, \"admin\": {\"api\": {\"title\": \"API Access\", \"revoke\": \"Revoke\", \"enabled\": \"API Enabled\", \"disabled\": \"API Disabled\", \"subtitle\": \"Manage keys to access the API\", \"noKeyInfo\": \"No API keys have been generated yet.\", \"headerName\": \"Name\", \"newKeyName\": \"Name\", \"newKeyGroup\": \"Group\", \"newKeyTitle\": \"New API Key\", \"enableButton\": \"Enable API\", \"expiration1y\": \"1 year\", \"expiration3y\": \"3 years\", \"headerRevoke\": \"Revoke\", \"newKeyButton\": \"New API Key\", \"disableButton\": \"Disable API\", \"expiration30d\": \"30 days\", \"expiration90d\": \"90 days\", \"headerCreated\": \"Created\", \"newKeySuccess\": \"API key created successfully.\", \"revokeConfirm\": \"Revoke API Key?\", \"revokeSuccess\": \"The key has been revoked successfully.\", \"expiration180d\": \"180 days\", \"newKeyCopyWarn\": \"Copy the key shown below as {{bold}}\", \"newKeyNameHint\": \"Purpose of this key\", \"refreshSuccess\": \"List of API keys has been refreshed.\", \"headerKeyEnding\": \"Key Ending\", \"newKeyGroupHint\": \"The API key will have the same permissions as the selected group.\", \"newKeyNameError\": \"Name is missing or invalid.\", \"headerExpiration\": \"Expiration\", \"newKeyExpiration\": \"Expiration\", \"newKeyFullAccess\": \"Full Access\", \"newKeyGroupError\": \"You must select a group.\", \"headerLastUpdated\": \"Last Updated\", \"revokeConfirmText\": \"Are you sure you want to revoke key {{name}}? This action cannot be undone!\", \"newKeyCopyWarnBold\": \"it will NOT be shown again\", \"newKeyExpirationHint\": \"You can still revoke a key anytime regardless of the expiration.\", \"newKeyGuestGroupError\": \"The guests group cannot be used for API keys.\", \"newKeyGroupPermissions\": \"or use group permissions...\", \"newKeyPermissionScopes\": \"Permission Scopes\", \"toggleStateEnabledSuccess\": \"API has been enabled successfully.\", \"toggleStateDisabledSuccess\": \"API has been disabled successfully.\"}, \"dev\": {\"flags\": {\"title\": \"Flags\"}, \"title\": \"Developer Tools\", \"voyager\": {\"title\": \"Voyager\"}, \"graphiql\": {\"title\": \"GraphiQL\"}}, \"nav\": {\"site\": \"Site\", \"users\": \"Users\", \"system\": \"System\", \"modules\": \"Modules\"}, \"ssl\": {\"ports\": \"Ports\", \"title\": \"SSL\", \"domain\": \"Domain\", \"status\": \"Certificate Status\", \"httpPort\": \"HTTP Port\", \"provider\": \"Provider\", \"subtitle\": \"Manage SSL configuration\", \"httpsPort\": \"HTTPS Port\", \"domainHint\": \"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)\", \"expiration\": \"Certificate Expiration\", \"currentState\": \"Current State\", \"httpPortHint\": \"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.\", \"providerHint\": \"Select Custom Certificate if you have your own certificate already.\", \"httpsPortHint\": \"SSL port the server will listen to for HTTPS requests. Usually 443.\", \"providerOptions\": \"Provider Options\", \"subscriberEmail\": \"Subscriber Email\", \"httpPortRedirect\": \"Redirect HTTP requests to HTTPS\", \"providerDisabled\": \"Disabled\", \"renewCertificate\": \"Renew Certificate\", \"providerLetsEncrypt\": \"Let\'s Encrypt\", \"httpPortRedirectHint\": \"Will automatically redirect any requests on the HTTP port to HTTPS.\", \"httpPortRedirectTurnOn\": \"Turn On\", \"httpPortRedirectTurnOff\": \"Turn Off\", \"renewCertificateSuccess\": \"Certificate renewed successfully.\", \"providerCustomCertificate\": \"Custom Certificate\", \"writableConfigFileWarning\": \"Note that your config file must be writable in order to persist ports configuration.\", \"httpPortRedirectSaveSuccess\": \"HTTP Redirection changed successfully.\", \"renewCertificateLoadingTitle\": \"Renewing Certificate...\", \"renewCertificateLoadingSubtitle\": \"Do not leave this page.\"}, \"auth\": {\"title\": \"Authentication\", \"force2fa\": \"Force all users to use Two-Factor Authentication (2FA)\", \"loginUrl\": \"Login URL\", \"security\": \"Security\", \"subtitle\": \"Configure the authentication settings of your wiki\", \"logoutUrl\": \"Logout URL\", \"strategies\": \"Strategies\", \"addStrategy\": \"Add Strategy\", \"callbackUrl\": \"Callback URL / Redirect URI\", \"displayName\": \"Display Name\", \"jwtAudience\": \"JWT Audience\", \"saveSuccess\": \"Authentication configuration saved successfully.\", \"force2faHint\": \"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.\", \"registration\": \"Registration\", \"strategyState\": \"This strategy is {{state}} {{locked}}\", \"refreshSuccess\": \"List of strategies has been refreshed.\", \"configReference\": \"Configuration Reference\", \"displayNameHint\": \"The title shown to the end user for this authentication strategy.\", \"jwtAudienceHint\": \"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)\", \"siteUrlNotSetup\": \"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.\", \"tokenExpiration\": \"Token Expiration\", \"activeStrategies\": \"Active Strategies\", \"autoEnrollGroups\": \"Assign to group\", \"domainsWhitelist\": \"Limit to specific email domains\", \"selfRegistration\": \"Allow self-registration\", \"allowedWebOrigins\": \"Allowed Web Origins\", \"globalAdvSettings\": \"Global Advanced Settings\", \"strategyIsEnabled\": \"Active\", \"tokenRenewalPeriod\": \"Token Renewal Period\", \"strategyStateActive\": \"active\", \"strategyStateLocked\": \"and cannot be disabled.\", \"tokenExpirationHint\": \"The expiration period of a token until it must be renewed. (default: 30m)\", \"autoEnrollGroupsHint\": \"Automatically assign new users to these groups.\", \"domainsWhitelistHint\": \"A list of domains authorized to register. The user email address domain must match one of these to gain access.\", \"selfRegistrationHint\": \"Allow any user successfully authorized by the strategy to access the wiki.\", \"strategyConfiguration\": \"Strategy Configuration\", \"strategyIsEnabledHint\": \"Are users able to login using this strategy?\", \"strategyStateInactive\": \"not active\", \"tokenRenewalPeriodHint\": \"The maximum period a token can be renewed when expired. (default: 14d)\", \"configReferenceSubtitle\": \"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.\", \"strategyNoConfiguration\": \"This strategy has no configuration options you can modify.\", \"tokenEndpointAuthMethod\": \"Token Endpoint Authentication Method\"}, \"mail\": {\"dkim\": \"DKIM (optional)\", \"smtp\": \"SMTP Settings\", \"test\": \"Send a test email\", \"title\": \"Mail\", \"sender\": \"Sender\", \"dkimUse\": \"Use DKIM\", \"smtpPwd\": \"Password\", \"smtpTLS\": \"Secure (TLS)\", \"dkimHint\": \"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.\", \"smtpHost\": \"Host\", \"smtpName\": \"Client Identifying Hostname\", \"smtpPort\": \"Port\", \"smtpUser\": \"Username\", \"subtitle\": \"Configure mail settings\", \"testHint\": \"Send a test email to ensure your SMTP configuration is working.\", \"testSend\": \"Send Email\", \"senderName\": \"Sender Name\", \"saveSuccess\": \"Configuration saved successfully.\", \"senderEmail\": \"Sender Email\", \"smtpTLSHint\": \"Should be enabled when using port 465, otherwise turned off (587 or 25).\", \"smtpNameHint\": \"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name.\", \"smtpPortHint\": \"Usually 465 (recommended), 587 or 25.\", \"configuration\": \"Configuration\", \"smtpVerifySSL\": \"Verify SSL Certificate\", \"testRecipient\": \"Recipient Email Address\", \"dkimDomainName\": \"Domain Name\", \"dkimPrivateKey\": \"Private Key\", \"dkimKeySelector\": \"Key Selector\", \"sendTestSuccess\": \"A test email was sent successfully.\", \"smtpVerifySSLHint\": \"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.\", \"dkimPrivateKeyHint\": \"Private key for the selector in PEM format\"}, \"tags\": {\"tag\": \"Tag\", \"date\": \"Created {{created}} and last updated {{updated}}.\", \"edit\": \"Edit Tag\", \"label\": \"Label\", \"title\": \"Tags\", \"delete\": \"Delete this tag\", \"filter\": \"Filter...\", \"subtitle\": \"Manage page tags\", \"emptyList\": \"No tags to display.\", \"noItemsText\": \"Add a tag to a page to get started.\", \"saveSuccess\": \"Tag has been saved successfully.\", \"deleteConfirm\": \"Delete Tag?\", \"deleteSuccess\": \"Tag deleted successfully.\", \"refreshSuccess\": \"Tags have been refreshed.\", \"noSelectionText\": \"Select a tag from the list on the left.\", \"viewLinkedPages\": \"View Linked Pages\", \"deleteConfirmText\": \"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages.\"}, \"pages\": {\"title\": \"Pages\"}, \"stats\": {\"title\": \"Statistics\"}, \"theme\": {\"title\": \"Theme\", \"iconset\": \"Icon Set\", \"options\": \"Theme Options\", \"darkMode\": \"Dark Mode\", \"subtitle\": \"Modify the look & feel of your wiki\", \"siteTheme\": \"Site Theme\", \"cssOverride\": \"CSS Override\", \"iconsetHint\": \"Set of icons to use for the sidebar navigation.\", \"darkModeHint\": \"Not recommended for accessibility. May not be supported by all themes.\", \"downloadName\": \"Name\", \"codeInjection\": \"Code Injection\", \"siteThemeHint\": \"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.\", \"downloadAuthor\": \"Author\", \"downloadThemes\": \"Download Themes\", \"cssOverrideHint\": \"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.\", \"downloadDownload\": \"Download\", \"tocHeadingLevels\": \"Default TOC Heading Levels\", \"bodyHtmlInjection\": \"Body HTML Injection\", \"headHtmlInjection\": \"Head HTML Injection\", \"cssOverrideWarning\": \"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!\", \"tocHeadingLevelsHint\": \"The table of contents will show headings from and up to the selected levels by default.\", \"bodyHtmlInjectionHint\": \"HTML code to be injected just before the closing body tag.\", \"headHtmlInjectionHint\": \"HTML code to be injected just before the closing head tag. Usually for script tags.\", \"cssOverrideWarningCaution\": \"CAUTION:\"}, \"users\": {\"id\": \"ID {{id}}\", \"tfa\": \"Two Factor Authentication (2FA)\", \"edit\": \"Edit User\", \"email\": \"Email\", \"title\": \"Users\", \"active\": \"Active\", \"groups\": \"User Groups\", \"inactive\": \"Inactive\", \"jobTitle\": \"Job Title\", \"location\": \"Location\", \"password\": \"Password\", \"timezone\": \"Timezone\", \"verified\": \"Verified\", \"basicInfo\": \"Basic Info\", \"toggle2FA\": \"Toggle 2FA\", \"unverified\": \"Unverified\", \"updateUser\": \"Update User\", \"displayName\": \"Display Name\", \"groupAssign\": \"Assign\", \"newPassword\": \"New Password\", \"selectGroup\": \"Select Group...\", \"authProvider\": \"Provider\", \"authProviderId\": \"Provider Id\", \"authentication\": \"Authentication\", \"changePassword\": \"Change Password\", \"noGroupAssigned\": \"This user is not assigned to any group yet. You must assign at least 1 group to a user.\", \"extendedMetadata\": \"Extended Metadata\", \"deleteConfirmText\": \"Are you sure you want to delete user {{username}}?\", \"groupAssignNotice\": \"Note that you cannot assign users to the Administrators or Guests groups from this panel.\", \"userUpdateSuccess\": \"User updated successfully.\", \"userVerifySuccess\": \"User has been verified successfully.\", \"deleteConfirmTitle\": \"Delete User?\", \"userActivateSuccess\": \"User has been activated successfully.\", \"userTFAEnableSuccess\": \"2FA was enabled successfully.\", \"userDeactivateSuccess\": \"User deactivated successfully.\", \"userTFADisableSuccess\": \"2FA was disabled successfully.\", \"deleteConfirmReplaceWarn\": \"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don\'t want the content to be reassigned to any current active user.\", \"deleteConfirmForeignNotice\": \"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.\", \"userAlreadyAssignedToGroup\": \"User is already assigned to this group!\"}, \"editor\": {\"title\": \"Editor\"}, \"groups\": {\"title\": \"Groups\"}, \"locale\": {\"rtl\": \"RTL\", \"base\": {\"hint\": \"All UI text elements will be displayed in selected language.\", \"label\": \"Site Locale\", \"labelWithNS\": \"Base Locale\"}, \"code\": \"Code\", \"name\": \"Name\", \"title\": \"Locale\", \"download\": \"Download\", \"settings\": \"Locale Settings\", \"sideload\": \"Sideload Locale Package\", \"subtitle\": \"Set localization options for your wiki\", \"autoUpdate\": {\"hint\": \"Automatically download updates to this locale as they become available.\", \"label\": \"Update Automatically\", \"hintWithNS\": \"Automatically download updates to all namespaced locales enabled below.\"}, \"namespaces\": {\"hint\": \"Enables multiple language versions of the same page.\", \"label\": \"Multilingual Namespaces\"}, \"nativeName\": \"Native Name\", \"namespacing\": \"Multilingual Namespacing\", \"availability\": \"Availability\", \"sideloadHelp\": \"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.\", \"downloadTitle\": \"Download Locale\", \"activeNamespaces\": {\"hint\": \"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection.\", \"label\": \"Active Namespaces\"}, \"namespacingPrefixWarning\": {\"title\": \"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)\", \"subtitle\": \"Paths without a locale code will be automatically redirected to the base locale defined above.\"}}, \"search\": {\"title\": \"Search Engine\", \"subtitle\": \"Configure the search capabilities of your wiki\", \"engineConfig\": \"Engine Configuration\", \"rebuildIndex\": \"Rebuild Index\", \"searchEngine\": \"Search Engine\", \"engineNoConfig\": \"This engine has no configuration options you can modify.\", \"configSaveSuccess\": \"Search engine configuration saved successfully.\", \"listRefreshSuccess\": \"List of search engines has been refreshed.\", \"indexRebuildSuccess\": \"Index rebuilt successfully.\"}, \"system\": {\"os\": \"Operating System\", \"title\": \"System Info\", \"cpuCores\": \"CPU Cores\", \"hostInfo\": \"Host Information\", \"hostname\": \"Hostname\", \"ramUsage\": \"RAM Usage: {{used}} / {{total}}\", \"subtitle\": \"Information about your system\", \"totalRAM\": \"Total RAM\", \"published\": \"Published\", \"configFile\": \"Configuration File\", \"latestVersion\": \"Latest Version\", \"currentVersion\": \"Current Version\", \"refreshSuccess\": \"System Info has been refreshed.\", \"dbPartialSupport\": \"Your database version is not fully supported. Some functionality may be limited or not work as expected.\", \"workingDirectory\": \"Working Directory\"}, \"general\": {\"logo\": \"Logo\", \"title\": \"General\", \"editFab\": \"FAB Quick Edit Menu\", \"general\": \"General\", \"logoUrl\": \"Logo URL\", \"siteUrl\": \"Site URL\", \"siteInfo\": \"Site Info\", \"subtitle\": \"Main settings of your wiki\", \"siteTitle\": \"Site Title\", \"metaRobots\": \"Meta Robots\", \"uploadLogo\": \"Upload Logo\", \"companyName\": \"Company / Organization Name\", \"editFabHint\": \"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.\", \"editMenuBar\": \"Edit Menu Bar\", \"logoUrlHint\": \"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.\", \"saveSuccess\": \"Site configuration saved successfully.\", \"siteUrlHint\": \"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)\", \"uploadClear\": \"Clear\", \"siteBranding\": \"Site Branding\", \"editShortcuts\": \"Edit Shortcuts\", \"siteTitleHint\": \"Displayed in the top bar and appended to all pages meta title.\", \"contentLicense\": \"Content License\", \"footerOverride\": \"Footer Text Override\", \"metaRobotsHint\": \"Default: Index, Follow. Can also be set on a per-page basis.\", \"pageExtensions\": \"Page Extensions\", \"uploadSizeHint\": \"An image of {{size}} pixels is recommended for best results.\", \"companyNameHint\": \"Name to use when displaying copyright notice in the footer. Leave empty to hide.\", \"footerCopyright\": \"Footer Copyright\", \"siteDescription\": \"Site Description\", \"uploadTypesHint\": \"{{typeList}} or {{lastType}} files only\", \"contentLicenseHint\": \"License shown in the footer of all content pages.\", \"displayEditMenuBar\": \"Display Edit Menu Bar\", \"displayEditMenuBtn\": \"Display Edit Button\", \"footerOverrideHint\": \"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate.\", \"pageExtensionsHint\": \"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.\", \"editMenuExternalUrl\": \"Button URL\", \"siteDescriptionHint\": \"Default description when none is provided for a page.\", \"editMenuExternalIcon\": \"Button Icon\", \"editMenuExternalName\": \"Button Site Name\", \"siteTitleInvalidChars\": \"Site Title contains invalid characters.\", \"displayEditMenuBarHint\": \"Display the edit menu bar in the page header.\", \"displayEditMenuBtnHint\": \"Display a button to edit the current page.\", \"editMenuExternalUrlHint\": \"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )\", \"editMenuExternalIconHint\": \"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.\", \"editMenuExternalNameHint\": \"The name of the external site to display on the edit button. Do not include the \\\"Edit on\\\" prefix.\", \"displayEditMenuExternalBtn\": \"Display External Edit Button\", \"displayEditMenuExternalBtnHint\": \"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.\"}, \"logging\": {\"title\": \"Logging\"}, \"storage\": {\"title\": \"Storage\", \"status\": \"Status\", \"actions\": \"Actions\", \"targets\": \"Targets\", \"errorMsg\": \"Error Message\", \"lastSync\": \"Last synchronization {{time}}\", \"noTarget\": \"You don\'t have any active storage target.\", \"subtitle\": \"Set backup and sync targets for your content\", \"actionRun\": \"Run\", \"syncDirBi\": \"Bi-directional\", \"syncDirPull\": \"Pull from target\", \"syncDirPush\": \"Push to target\", \"targetState\": \"This storage target is {{state}}\", \"unsupported\": \"Unsupported\", \"syncSchedule\": \"Sync Schedule\", \"targetConfig\": \"Target Configuration\", \"syncDirBiHint\": \"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.\", \"syncDirection\": \"Sync Direction\", \"noConfigOption\": \"This storage target has no configuration options you can modify.\", \"lastSyncAttempt\": \"Last attempt was {{time}}\", \"syncDirPullHint\": \"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!\", \"syncDirPushHint\": \"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.\", \"syncScheduleHint\": \"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.\", \"targetStateActive\": \"active\", \"actionsInactiveWarn\": \"You must enable this storage target and apply changes before you can run actions.\", \"syncScheduleCurrent\": \"Currently set to every {{schedule}}.\", \"syncScheduleDefault\": \"The default is every {{schedule}}.\", \"targetStateInactive\": \"inactive\", \"syncDirectionSubtitle\": \"Choose how content synchronization is handled for this storage target.\"}, \"comments\": {\"title\": \"Comments\", \"provider\": \"Provider\", \"subtitle\": \"Add discussions to your wiki pages\", \"providerConfig\": \"Provider Configuration\", \"providerNoConfig\": \"This provider has no configuration options you can modify.\", \"configSaveSuccess\": \"Comments configuration saved successfully.\"}, \"security\": {\"jwt\": \"JWT Configuration\", \"login\": \"Login\", \"title\": \"Security\", \"uploads\": \"Uploads\", \"subtitle\": \"Configure security settings\", \"enforce2fa\": \"Enforce 2FA\", \"loginBgUrl\": \"Login Background Image URL\", \"bypassLogin\": \"Bypass Login Screen\", \"loginScreen\": \"Login Screen\", \"uploadsInfo\": \"These settings only affect Wiki.js. If you\'re using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.\", \"loginSecurity\": \"Security\", \"maxUploadSize\": \"Max Upload Size\", \"enforce2faHint\": \"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form.\", \"hideLocalLogin\": \"Hide Local Authentication Provider\", \"loginBgUrlHint\": \"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!\", \"maxUploadBatch\": \"Max Files per Upload\", \"bypassLoginHint\": \"Should the user be redirected automatically to the first authentication provider.\", \"maxUploadSizeHint\": \"The maximum size for a single file.\", \"hideLocalLoginHint\": \"Don\'t show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.\", \"maxUploadBatchHint\": \"How many files can be uploaded in a single batch?\", \"maxUploadSizeSuffix\": \"bytes\", \"maxUploadBatchSuffix\": \"files\"}, \"webhooks\": {\"title\": \"Webhooks\", \"subtitle\": \"Manage webhooks to external services\"}, \"adminArea\": \"Administration Area\", \"analytics\": {\"title\": \"Analytics\", \"subtitle\": \"Add analytics and tracking tools to your wiki\", \"providers\": \"Providers\", \"saveSuccess\": \"Analytics configuration saved successfully\", \"refreshSuccess\": \"List of providers refreshed successfully.\", \"providerConfiguration\": \"Provider Configuration\", \"providerNoConfiguration\": \"This provider has no configuration options you can modify.\"}, \"dashboard\": {\"pages\": \"Pages\", \"title\": \"Dashboard\", \"users\": \"Users\", \"groups\": \"Groups\", \"subtitle\": \"Wiki.js\", \"lastLogins\": \"Last Logins\", \"versionNew\": \"A new version is available: {{version}}\", \"recentPages\": \"Recent Pages\", \"versionLatest\": \"You are running the latest version.\", \"contributeHelp\": \"We need your help!\", \"mostPopularPages\": \"Most Popular Pages\", \"contributeSubtitle\": \"Wiki.js is a free and open source project. There are several ways you can contribute to the project.\", \"contributeLearnMore\": \"Learn More\"}, \"rendering\": {\"title\": \"Rendering\", \"subtitle\": \"Configure the page rendering pipeline\"}, \"utilities\": {\"title\": \"Utilities\", \"tools\": \"Tools\", \"subtitle\": \"Maintenance and miscellaneous tools\", \"authTitle\": \"Authentication\", \"cacheTitle\": \"Flush Cache\", \"exportTitle\": \"Export to Disk\", \"authSubtitle\": \"Various tools for authentication / users\", \"contentTitle\": \"Content\", \"cacheSubtitle\": \"Flush cache of various components\", \"importv1Title\": \"Import from Wiki.js 1.x\", \"exportSubtitle\": \"Save content to tarball for backup / migration\", \"telemetryTitle\": \"Telemetry\", \"contentSubtitle\": \"Various tools for pages\", \"importv1Subtitle\": \"Migrate data from a previous 1.x installation\", \"telemetrySubtitle\": \"Enable/Disable telemetry or reset the client ID\", \"graphEndpointTitle\": \"GraphQL Endpoint\", \"graphEndpointSubtitle\": \"Change the GraphQL endpoint for Wiki.js\"}, \"contribute\": {\"shop\": \"Wiki.js Shop\", \"title\": \"Contribute to Wiki.js\", \"github\": \"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard\'s goal of working full-time on Wiki.js)\", \"paypal\": \"Make a one-time or recurring donation via Paypal:\", \"patreon\": \"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard\'s goal of working full-time on Wiki.js)\", \"tshirts\": \"You can also buy Wiki.js t-shirts to support the project financially:\", \"ethereum\": \"We accept donations using Ethereum:\", \"subtitle\": \"Help support Wiki.js development and operations\", \"foundABug\": \"Found a bug? Submit an issue on {{0}}.\", \"contribute\": \"Contribute\", \"openSource\": \"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.\", \"fundOurWork\": \"Fund our work\", \"needYourHelp\": \"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).\", \"submitAnIdea\": \"Submit an idea or vote on a proposed one on the {{0}}.\", \"becomeAPatron\": \"Become a Patron\", \"helpTranslate\": \"Help translate Wiki.js in your language. Let us know on {{0}}.\", \"makeADonation\": \"Make a donation\", \"spreadTheWord\": \"Spread the word\", \"talkToFriends\": \"Talk to your friends and colleagues about how awesome Wiki.js is!\", \"becomeASponsor\": \"Become a Sponsor\", \"openCollective\": \"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:\", \"submitAnIdeaLink\": \"feature requests board\", \"followUsOnTwitter\": \"Follow us on {{0}}.\", \"openSourceContributors\": \"contributors\"}, \"extensions\": {\"title\": \"Extensions\", \"subtitle\": \"Install extensions for extra functionality\"}, \"navigation\": {\"edit\": \"Edit {{kind}}\", \"icon\": \"Icon\", \"link\": \"Link\", \"mode\": \"Navigation Mode\", \"label\": \"Label\", \"title\": \"Navigation\", \"delete\": \"Delete {{kind}}\", \"header\": \"Header\", \"target\": \"Target\", \"divider\": \"Divider\", \"navType\": {\"home\": \"Home\", \"page\": \"Page\", \"external\": \"External Link\", \"searchQuery\": \"Search Query\", \"externalblank\": \"External Link (New Window)\"}, \"modeNone\": {\"title\": \"None\", \"description\": \"Disable Site Navigation\"}, \"subtitle\": \"Manage the site navigation\", \"untitled\": \"Untitled {{kind}}\", \"emptyList\": \"Navigation is empty\", \"modeCustom\": {\"title\": \"Custom Navigation\", \"description\": \"Static Navigation Menu + Site Tree Button\"}, \"modeStatic\": {\"title\": \"Static Navigation\", \"description\": \"Static Navigation Menu Only\"}, \"targetType\": \"Target Type\", \"noItemsText\": \"Click the Add button to add your first navigation item.\", \"saveSuccess\": \"Navigation saved successfully.\", \"modeSiteTree\": {\"title\": \"Site Tree\", \"description\": \"Classic Tree-based Navigation\"}, \"sourceLocale\": \"Source Locale\", \"copyFromLocale\": \"Copy from locale...\", \"visibilityMode\": {\"all\": \"Visible to everyone\", \"restricted\": \"Visible to select groups...\"}, \"noSelectionText\": \"Select a navigation item on the left.\", \"selectPageButton\": \"Select Page...\", \"sourceLocaleHint\": \"The locale from which navigation items will be copied from.\", \"copyFromLocaleInfoText\": \"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.\"}}, \"common\": {\"page\": {\"id\": \"ID {{id}}\", \"toc\": \"Page Contents\", \"tags\": \"Tags\", \"share\": \"Share\", \"delete\": \"Delete Page\", \"global\": \"Global\", \"convert\": \"Convert Page\", \"loading\": \"Loading Page...\", \"private\": \"Private\", \"bookmark\": \"Bookmark\", \"editPage\": \"Edit Page\", \"published\": \"Published\", \"versionId\": \"Version ID {{id}}\", \"deleteTitle\": \"Are you sure you want to delete page {{title}}?\", \"printFormat\": \"Print Format\", \"unpublished\": \"Unpublished\", \"convertTitle\": \"Select the editor you want to use going forward for the page {{title}}:\", \"editExternal\": \"Edit on {{name}}\", \"lastEditedBy\": \"Last edited by\", \"tagsMatching\": \"Pages matching tags\", \"viewingSource\": \"Viewing source of page {{path}}\", \"deleteSubtitle\": \"The page can be restored from the administration area.\", \"convertSubtitle\": \"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.\", \"returnNormalView\": \"Return to Normal View\", \"unpublishedWarning\": \"This page is not published.\", \"viewingSourceVersion\": \"Viewing source as of {{date}} of page {{path}}\"}, \"user\": {\"search\": \"Search User\", \"searchPlaceholder\": \"Search Users...\"}, \"error\": {\"unexpected\": \"An unexpected error occurred.\"}, \"footer\": {\"license\": \"Content is available under the {{license}}, by {{company}}.\", \"copyright\": \"© {{year}} {{company}}. All rights reserved.\", \"poweredBy\": \"Powered by\"}, \"header\": {\"edit\": \"Edit\", \"home\": \"Home\", \"move\": \"Move / Rename\", \"view\": \"View\", \"admin\": \"Administration\", \"login\": \"Login\", \"assets\": \"Assets\", \"delete\": \"Delete\", \"logout\": \"Logout\", \"myWiki\": \"My Wiki\", \"search\": \"Search...\", \"account\": \"Account\", \"convert\": \"Convert\", \"history\": \"History\", \"newPage\": \"New Page\", \"profile\": \"Profile\", \"siteMap\": \"Site Map\", \"language\": \"Language\", \"duplicate\": \"Duplicate\", \"browseTags\": \"Browse by Tags\", \"searchHint\": \"Type at least 2 characters to start searching...\", \"viewSource\": \"View Source\", \"currentPage\": \"Current Page\", \"imagesFiles\": \"Images & Files\", \"pageActions\": \"Page Actions\", \"searchClose\": \"Close\", \"searchLoading\": \"Searching...\", \"searchCopyLink\": \"Copy Search Link\", \"searchNoResult\": \"No pages matching your query.\", \"searchDidYouMean\": \"Did you mean...\", \"searchResultsCount\": \"Found {{total}} results\"}, \"actions\": {\"ok\": \"OK\", \"add\": \"Add\", \"copy\": \"Copy\", \"edit\": \"Edit\", \"exit\": \"Exit\", \"move\": \"Move\", \"page\": \"Page\", \"save\": \"Save\", \"apply\": \"Apply\", \"clear\": \"Clear\", \"close\": \"Close\", \"fetch\": \"Fetch\", \"browse\": \"Browse...\", \"cancel\": \"Cancel\", \"create\": \"Create\", \"delete\": \"Delete\", \"insert\": \"Insert\", \"rename\": \"Rename\", \"select\": \"Select\", \"upload\": \"Upload\", \"confirm\": \"Confirm\", \"convert\": \"Convert\", \"discard\": \"Discard\", \"preview\": \"Preview\", \"proceed\": \"Proceed\", \"refresh\": \"Refresh\", \"download\": \"Download\", \"generate\": \"Generate\", \"optimize\": \"Optimize\", \"properties\": \"Properties\", \"returnToTop\": \"Return to top\", \"saveChanges\": \"Save Changes\", \"discardChanges\": \"Discard Changes\"}, \"license\": {\"alr\": \"All Rights Reserved\", \"cc0\": \"Public Domain\", \"ccby\": \" Creative Commons Attribution License\", \"none\": \"None\", \"ccbync\": \"Creative Commons Attribution-NonCommercial License\", \"ccbynd\": \"Creative Commons Attribution-NoDerivs License\", \"ccbysa\": \"Creative Commons Attribution-ShareAlike License\", \"ccbyncnd\": \"Creative Commons Attribution-NonCommercial-NoDerivs License\", \"ccbyncsa\": \"Creative Commons Attribution-NonCommercial-ShareAlike License\"}, \"newpage\": {\"title\": \"This page does not exist yet.\", \"create\": \"Create Page\", \"goback\": \"Go back\", \"subtitle\": \"Would you like to create it now?\"}, \"sidebar\": {\"root\": \"(root)\", \"browse\": \"Browse\", \"mainMenu\": \"Main Menu\", \"currentDirectory\": \"Current Directory\"}, \"welcome\": {\"title\": \"Welcome to your wiki!\", \"goadmin\": \"Administration\", \"subtitle\": \"Let\'s get started and create the home page.\", \"createhome\": \"Create Home Page\"}, \"comments\": {\"none\": \"No comments yet.\", \"title\": \"Comments\", \"beFirst\": \"Be the first to comment.\", \"loading\": \"Loading comments...\", \"sdTitle\": \"Talk\", \"modified\": \"modified {{reldate}}\", \"fieldName\": \"Your Name\", \"postingAs\": \"Posting as {{name}}\", \"deleteWarn\": \"Are you sure you want to permanently delete this comment?\", \"fieldEmail\": \"Your Email Address\", \"newComment\": \"New Comment\", \"postComment\": \"Post Comment\", \"postSuccess\": \"New comment posted successfully.\", \"fieldContent\": \"Comment Content\", \"deleteSuccess\": \"Comment was deleted successfully.\", \"updateComment\": \"Update Comment\", \"updateSuccess\": \"Comment was updated successfully.\", \"markdownFormat\": \"Markdown Format\", \"newPlaceholder\": \"Write a new comment...\", \"viewDiscussion\": \"View Discussion\", \"deleteConfirmTitle\": \"Confirm Delete\", \"contentMissingError\": \"Comment is empty or too short!\", \"deletePermanentWarn\": \"This action cannot be undone!\"}, \"duration\": {\"days\": \"Day(s)\", \"every\": \"Every\", \"hours\": \"Hour(s)\", \"years\": \"Year(s)\", \"months\": \"Month(s)\", \"minutes\": \"Minute(s)\"}, \"notfound\": {\"title\": \"Not Found\", \"gohome\": \"Home\", \"subtitle\": \"This page does not exist.\"}, \"password\": {\"weak\": \"Weak\", \"strong\": \"Strong\", \"average\": \"Average\", \"veryWeak\": \"Very Weak\", \"veryStrong\": \"Very Strong\"}, \"pageSelector\": {\"pages\": \"Pages\", \"moveTitle\": \"Move / Rename Page Location\", \"createTitle\": \"Select New Page Location\", \"selectTitle\": \"Select a Page\", \"virtualFolders\": \"Virtual Folders\", \"folderEmptyWarning\": \"This folder is empty.\"}, \"unauthorized\": {\"login\": \"Login As...\", \"title\": \"Unauthorized\", \"action\": {\"edit\": \"You cannot edit the page.\", \"view\": \"You cannot view this page.\", \"create\": \"You cannot create the page.\", \"source\": \"You cannot view the page source.\", \"history\": \"You cannot view the page history.\", \"download\": \"You cannot download the page content.\", \"sourceVersion\": \"You cannot view the source of this version of the page.\", \"downloadVersion\": \"You cannot download the content for this page version.\"}, \"goback\": \"Go Back\"}, \"modernBrowser\": \"modern browser\", \"outdatedBrowserWarning\": \"Your browser is outdated. Upgrade to a {{modernBrowser}}.\"}, \"editor\": {\"page\": \"Page\", \"save\": {\"error\": \"An error occurred while creating the page\", \"saved\": \"Saved\", \"pleaseWait\": \"Please wait...\", \"processing\": \"Rendering\", \"createSuccess\": \"Page created successfully.\", \"updateSuccess\": \"Page updated successfully.\"}, \"props\": {\"css\": \"CSS\", \"toc\": \"TOC\", \"html\": \"HTML\", \"info\": \"Info\", \"path\": \"Path\", \"tags\": \"Tags\", \"title\": \"Title\", \"locale\": \"Locale\", \"social\": \"Social\", \"styles\": \"Styles\", \"cssHint\": \"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.\", \"scripts\": \"Scripts\", \"htmlHint\": \"You must surround your javascript code with HTML script tags.\", \"pageInfo\": \"Page Info\", \"pathHint\": \"Do not include any leading or trailing slashes.\", \"tagsHint\": \"Use tags to categorize your pages and make them easier to find.\", \"tocTitle\": \"Table of Contents\", \"publishEnd\": \"Publish ending on...\", \"scheduling\": \"Scheduling\", \"allowRatings\": \"Allow Ratings\", \"publishStart\": \"Publish starting on...\", \"publishState\": \"Publishing State\", \"allowComments\": \"Allow Comments\", \"displayAuthor\": \"Display Author Info\", \"publishToggle\": \"Published\", \"tocUseDefault\": \"Use Site Defaults\", \"categorization\": \"Categorization\", \"pageProperties\": \"Page Properties\", \"publishEndHint\": \"Leave empty for no end date\", \"socialFeatures\": \"Social Features\", \"allowRatingsHint\": \"Enable rating capabilities on this page.\", \"publishStartHint\": \"Leave empty for no start date\", \"shortDescription\": \"Short Description\", \"tocHeadingLevels\": \"TOC Heading Levels\", \"allowCommentsHint\": \"Enable commenting abilities on this page.\", \"displayAuthorHint\": \"Show the page author along with the last edition time.\", \"displaySharingBar\": \"Display Sharing Toolbar\", \"publishToggleHint\": \"Unpublished pages are still visible to users with write permissions on this page.\", \"pathCategorization\": \"Path & Categorization\", \"shortDescriptionHint\": \"Shown below the title\", \"tocHeadingLevelsHint\": \"The table of contents will show headings from and up to the selected levels.\", \"displaySharingBarHint\": \"Show a toolbar with buttons to share and print this page\"}, \"assets\": {\"title\": \"Assets\", \"headerId\": \"ID\", \"fileCount\": \"{{count}} files\", \"newFolder\": \"New Folder\", \"fetchImage\": \"Fetch Remote Image\", \"folderName\": \"Folder Name\", \"headerType\": \"Type\", \"imageAlign\": \"Image Alignment\", \"deleteAsset\": \"Delete Asset\", \"folderEmpty\": \"This asset folder is empty.\", \"headerAdded\": \"Added\", \"renameAsset\": \"Rename Asset\", \"uploadAssets\": \"Upload Assets\", \"uploadFailed\": \"File upload failed.\", \"deleteSuccess\": \"Asset deleted successfully.\", \"headerActions\": \"Actions\", \"noUploadError\": \"You must choose a file to upload first!\", \"renameSuccess\": \"Asset renamed successfully.\", \"headerFileSize\": \"File Size\", \"headerFilename\": \"Filename\", \"refreshSuccess\": \"List of assets refreshed successfully.\", \"deleteAssetWarn\": \"This action cannot be undone!\", \"deleteAssetConfirm\": \"Are you sure you want to delete asset\", \"folderCreateSuccess\": \"Asset folder created successfully.\", \"renameAssetSubtitle\": \"Enter the new name for this asset:\", \"uploadAssetsDropZone\": \"Browse or Drop files here...\", \"folderNameNamingRules\": \"Must follow the asset folder {{namingRules}}.\", \"folderNameNamingRulesLink\": \"naming rules\"}, \"markup\": {\"bold\": \"Bold\", \"italic\": \"Italic\", \"heading\": \"Heading {{level}}\", \"subscript\": \"Subscript\", \"blockquote\": \"Blockquote\", \"inlineCode\": \"Inline Code\", \"insertLink\": \"Insert Link\", \"insertBlock\": \"Insert Block\", \"keyboardKey\": \"Keyboard Key\", \"orderedList\": \"Ordered List\", \"superscript\": \"Superscript\", \"tableHelper\": \"Table Helper\", \"insertAssets\": \"Insert Assets\", \"horizontalBar\": \"Horizontal Bar\", \"insertDiagram\": \"Insert Diagram\", \"strikethrough\": \"Strikethrough\", \"unorderedList\": \"Unordered List\", \"blockquoteInfo\": \"Info Blockquote\", \"blockquoteError\": \"Error Blockquote\", \"insertCodeBlock\": \"Insert Code Block\", \"insertVideoAudio\": \"Insert Video / Audio\", \"noSelectionError\": \"Text must be selected first!\", \"toggleSpellcheck\": \"Toggle Spellcheck\", \"blockquoteSuccess\": \"Success Blockquote\", \"blockquoteWarning\": \"Warning Blockquote\", \"togglePreviewPane\": \"Hide / Show Preview Pane\", \"distractionFreeMode\": \"Distraction Free Mode\", \"insertMathExpression\": \"Insert Math Expression\", \"markdownFormattingHelp\": \"Markdown Formatting Help\"}, \"select\": {\"title\": \"Which editor do you want to use for this page?\", \"customView\": \"or create a custom view?\", \"cannotChange\": \"This cannot be changed once the page is created.\"}, \"unsaved\": {\"body\": \"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?\", \"title\": \"Discard Unsaved Changes?\"}, \"ckeditor\": {\"stats\": \"{{chars}} chars, {{words}} words\"}, \"conflict\": {\"title\": \"Resolve Save Conflict\", \"warning\": \"Save conflict! Another user has already modified this page.\", \"editable\": \"(editable)\", \"readonly\": \"(read-only)\", \"useLocal\": \"Use Local\", \"whatToDo\": \"What do you want to do?\", \"overwrite\": {\"title\": \"Overwrite with Remote Version?\", \"editsLost\": \"Your current edits will be lost.\", \"description\": \"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}\"}, \"pageTitle\": \"Title:\", \"useRemote\": \"Use Remote\", \"infoGeneric\": \"A more recent version of this page was saved by {{authorName}}, {{date}}\", \"localVersion\": \"Local Version {{refEditable}}\", \"useLocalHint\": \"Use content in the left panel\", \"leftPanelInfo\": \"Your current edit, based on page version from {{date}}\", \"remoteVersion\": \"Remote Version {{refReadOnly}}\", \"useRemoteHint\": \"Discard local changes and use latest version\", \"whatToDoLocal\": \"Use your current local version and ignore the latest changes.\", \"rightPanelInfo\": \"Last edited by {{authorName}}, {{date}}\", \"whatToDoRemote\": \"Use the remote version (latest) and discard your changes.\", \"pageDescription\": \"Description:\", \"viewLatestVersion\": \"View Latest Version\"}, \"backToEditor\": \"Back to Editor\", \"unsavedWarning\": \"You have unsaved edits. Are you sure you want to leave the editor?\"}, \"history\": {\"restore\": {\"success\": \"Page version restored succesfully!\", \"confirmText\": \"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.\", \"confirmTitle\": \"Restore page version?\", \"confirmButton\": \"Restore\"}}, \"profile\": {\"auth\": {\"title\": \"Authentication\", \"provider\": \"Provider\", \"newPassword\": \"New Password\", \"changePassword\": \"Change Password\", \"verifyPassword\": \"Confirm New Password\", \"currentPassword\": \"Current Password\", \"changePassSuccess\": \"Password changed successfully.\"}, \"save\": {\"success\": \"Profile saved successfully.\"}, \"pages\": {\"title\": \"Pages\", \"subtitle\": \"List of pages I created or last modified\", \"emptyList\": \"No pages to display.\", \"headerPath\": \"Path\", \"headerTitle\": \"Title\", \"refreshSuccess\": \"Page list has been refreshed.\", \"headerCreatedAt\": \"Created\", \"headerUpdatedAt\": \"Last Updated\"}, \"title\": \"Profile\", \"groups\": {\"title\": \"Groups\"}, \"myInfo\": \"My Info\", \"activity\": {\"title\": \"Activity\", \"joinedOn\": \"Joined on\", \"lastLoginOn\": \"Last login on\", \"pagesCreated\": \"Pages created\", \"lastUpdatedOn\": \"Profile last updated on\", \"commentsPosted\": \"Comments posted\"}, \"comments\": {\"title\": \"Comments\"}, \"jobTitle\": \"Job Title\", \"location\": \"Location\", \"subtitle\": \"My personal info\", \"timezone\": \"Timezone\", \"appearance\": \"Appearance\", \"dateFormat\": \"Date Format\", \"displayName\": \"Display Name\", \"preferences\": \"Preferences\", \"localeDefault\": \"Locale Default\", \"appearanceDark\": \"Dark\", \"appearanceLight\": \"Light\", \"appearanceDefault\": \"Site Default\", \"viewPublicProfile\": \"View Public Profile\"}}',0,'English','English',100,'2025-04-18T01:27:15.637Z','2025-04-18T01:27:21.186Z'),('ja','{\"auth\": {\"tfa\": {\"title\": \"2段階認証\", \"subtitle\": \"セキュリティコードが必要です:\", \"placeholder\": \"XXXXXX\", \"verifyToken\": \"検証\"}, \"errors\": {\"loginError\": \"ログインエラー\", \"invalidLogin\": \"不正なログイン\", \"userNotFound\": \"ユーザーが見つかりません\", \"invalidLoginMsg\": \"Eメール又はパスワードが無効です\", \"tooManyAttempts\": \"試行回数が多すぎます\", \"invalidUserEmail\": \"無効なメールアドレス\", \"notYetAuthorized\": \"まだこのサイトにログインする権限がありません\", \"tooManyAttemptsMsg\": \"短期間に失敗した試行回数が多すぎます。{{time}}にもう一度お試しください\"}, \"fields\": {\"name\": \"名前\", \"email\": \"メールアドレス\", \"password\": \"パスワード\", \"username\": \"ユーザー名\", \"emailUser\": \"メールアドレスまたはユーザー名\", \"verifyPassword\": \"パスワードの確認\"}, \"actions\": {\"login\": \"ログイン\", \"register\": \"登録\"}, \"changePwd\": {\"loading\": \"パスワード変更中…\", \"proceed\": \"パスワードを変更する\", \"subtitle\": \"新しいパスワードを入力\", \"instructions\": \"新しいパスワードを入力:\", \"newPasswordPlaceholder\": \"新しいパスワード\", \"newPasswordVerifyPlaceholder\": \"新しいパスワードを確認\"}, \"providers\": {\"ldap\": \"LDAP / Active Directory\", \"azure\": \"Azure Active Directory\", \"local\": \"ローカル\", \"slack\": \"Slack\", \"github\": \"GitHub\", \"google\": \"Google ID\", \"facebook\": \"Facebook\", \"windowslive\": \"Microsoft Account\"}, \"signingIn\": \"ログインしています...\", \"pleaseWait\": \"しばらくお待ちください\", \"missingName\": \"名前が入力されていません\", \"nameTooLong\": \"名前が長すぎます\", \"registering\": \"アカウントを作成しています...\", \"genericError\": \"認証は利用できません\", \"invalidEmail\": \"メールアドレスが無効です\", \"loginSuccess\": \"ログインに成功しました。リダイレクトしています...\", \"missingEmail\": \"メールアドレスが入力されていません\", \"nameTooShort\": \"名前が短すぎます\", \"tfaFormTitle\": \"信頼できるデバイスから生成されたセキュリティコードを入力:\", \"loginRequired\": \"ログインが必要です\", \"registerTitle\": \"アカウントの作成\", \"switchToLogin\": {\"link\": \"代わりにログインする\", \"text\": \"すでにアカウントをお持ちですか？ {{link}}\"}, \"tfaSetupTitle\": \"管理者がアカウントの2段階認証 (2FA) を要求しています。\", \"invalidPassword\": \"有効なパスワードを入力してください\", \"missingPassword\": \"パスワードが入力されていません\", \"registerSuccess\": \"アカウントを作成しました\", \"enterCredentials\": \"資格情報を入力\", \"passwordNotMatch\": \"2つのパスワードが一致していません\", \"passwordTooShort\": \"パスワードが短すぎます\", \"registerSubTitle\": \"下記のフォームに記入し、アカウントを作成してください\", \"switchToRegister\": {\"link\": \"アカウントの作成\", \"text\": \"まだアカウントを持っていませんか？ {{link}}\"}, \"sendResetPassword\": \"パスワードをリセット\", \"forgotPasswordLink\": \"パスワードをお忘れですか？\", \"loginUsingStrategy\": \"{{strategy}}を使用してログイン\", \"registerCheckEmail\": \"メールを確認しアカウントを有効にしてください\", \"selectAuthProvider\": \"認証プロバイダを選択\", \"tfaSetupInstrFirst\": \"1) モバイル2FAアプリケーションで以下のQRコードをスキャン:\", \"forgotPasswordTitle\": \"パスワードを忘れた場合\", \"tfaSetupInstrSecond\": \"2) 信頼できるデバイスから生成されたセキュリティコードを入力:\", \"forgotPasswordCancel\": \"キャンセル\", \"invalidEmailUsername\": \"有効なメールアドレスまたはユーザー名を入力してください\", \"orLoginUsingStrategy\": \"またはログイン\", \"forgotPasswordLoading\": \"パスワードの再設定を申請中...\", \"forgotPasswordSuccess\": \"メールを確認してパスワードを再設定してください\", \"forgotPasswordSubtitle\": \"パスワードをリセットするためにあなたのメールアドレスを入力してください\"}, \"tags\": {\"locale\": \"言語\", \"orderBy\": \"並べ替え\", \"localeAny\": \"すべて\", \"noResults\": \"選択したタグを含むページが見つかりませんでした。\", \"orderByField\": {\"ID\": \"ID\", \"path\": \"パス\", \"title\": \"タイトル\", \"creationDate\": \"作成日\", \"lastModified\": \"最終更新\"}, \"clearSelection\": \"選択を解除\", \"pageLastUpdated\": \"最終更新 {{date}}\", \"currentSelection\": \"現在の選択\", \"selectOneMoreTags\": \"1つ以上のタグを選択\", \"noResultsWithFilter\": \"選択したフィルターに一致するページがみつかりません。\", \"selectOneMoreTagsHint\": \"左から1つ以上のタグを選択してください。\", \"retrievingResultsLoading\": \"ページを取得しています…\", \"searchWithinResultsPlaceholder\": \"検索結果を絞り込む…\"}, \"admin\": {\"api\": {\"title\": \"API アクセス\", \"revoke\": \"無効化\", \"enabled\": \"APIが有効\", \"disabled\": \"APIが無効\", \"subtitle\": \"APIにアクセスするためのキーを管理\", \"noKeyInfo\": \"APIキーはまだ生成されていません。\", \"headerName\": \"名前\", \"newKeyName\": \"名前\", \"newKeyGroup\": \"グループ\", \"newKeyTitle\": \"新しいAPIキー\", \"enableButton\": \"APIを有効にする\", \"expiration1y\": \"1年\", \"expiration3y\": \"3年\", \"headerRevoke\": \"無効化\", \"newKeyButton\": \"新しいAPIキー\", \"disableButton\": \"APIを無効にする\", \"expiration30d\": \"30日\", \"expiration90d\": \"90日\", \"headerCreated\": \"作成日時\", \"newKeySuccess\": \"APIキーは正常に作成されました。\", \"revokeConfirm\": \"APIキーを無効化しますか？\", \"revokeSuccess\": \"キーは正常に無効化されました。\", \"expiration180d\": \"180日\", \"newKeyCopyWarn\": \"以下に示す {{bold}} のキーをコピーしてください。\", \"newKeyNameHint\": \"このキーの目的\", \"refreshSuccess\": \"APIキーの一覧を更新しました。\", \"headerKeyEnding\": \"キーの末尾\", \"newKeyGroupHint\": \"APIキーは選択されたグループと同じ権限を持ちます。\", \"newKeyNameError\": \"名前が入力されていないか無効です。\", \"headerExpiration\": \"有効期限\", \"newKeyExpiration\": \"有効期限\", \"newKeyFullAccess\": \"全権アクセス\", \"newKeyGroupError\": \"グループを選択する必要があります。\", \"headerLastUpdated\": \"最終更新\", \"revokeConfirmText\": \"本当にキー {{name}} を無効化しますか？この操作は元に戻すことができません！\", \"newKeyCopyWarnBold\": \"後から再度表示することはできません\", \"newKeyExpirationHint\": \"有効期限に関係なく、いつでもキーを取り消すことができます。\", \"newKeyGuestGroupError\": \"ゲスト グループは API キーには使用できません。\", \"newKeyGroupPermissions\": \"グループ権限を使用\", \"newKeyPermissionScopes\": \"権限の範囲\", \"toggleStateEnabledSuccess\": \"APIは正常に有効化されました。\", \"toggleStateDisabledSuccess\": \"APIは正常に無効化されました。\"}, \"dev\": {\"flags\": {\"title\": \"フラグ\"}, \"title\": \"開発者ツール\", \"voyager\": {\"title\": \"Voyager\"}, \"graphiql\": {\"title\": \"GraphiQL\"}}, \"nav\": {\"site\": \"サイト\", \"users\": \"ユーザー\", \"system\": \"システム\", \"modules\": \"モジュール\"}, \"ssl\": {\"ports\": \"ポート\", \"title\": \"SSL\", \"domain\": \"ドメイン\", \"status\": \"証明書の状態\", \"httpPort\": \"HTTPポート\", \"provider\": \"プロバイダ\", \"subtitle\": \"SSL 構成の管理\", \"httpsPort\": \"HTTPSポート\", \"domainHint\": \"wikiの完全修飾ドメインを入力します。(例: wiki.example.com)\", \"expiration\": \"証明書の有効期限\", \"currentState\": \"現在の状態\", \"httpPortHint\": \"HTTP リクエストを非SSLで待ち受けるポートです。通常は80や3000です。\", \"providerHint\": \"既に独自の証明書がある場合は、カスタム証明書を選択します。\", \"httpsPortHint\": \"HTTPSリクエストを待ち受けるSSLポート。通常は443です。\", \"providerOptions\": \"プロバイダのオプション\", \"subscriberEmail\": \"購読者のメールアドレス\", \"httpPortRedirect\": \"HTTPリクエストをHTTPSにリダイレクトする\", \"providerDisabled\": \"無効\", \"renewCertificate\": \"証明書を更新する\", \"providerLetsEncrypt\": \"Let\'s Encrypt\", \"httpPortRedirectHint\": \"HTTPポートへのすべてのリクエストを自動的にHTTPSにリダイレクトします。\", \"httpPortRedirectTurnOn\": \"有効化\", \"httpPortRedirectTurnOff\": \"無効化\", \"renewCertificateSuccess\": \"証明書を更新しました。\", \"providerCustomCertificate\": \"カスタム証明書\", \"writableConfigFileWarning\": \"ポート構成を保存するには設定ファイルが書込み可能である必要があります。\", \"httpPortRedirectSaveSuccess\": \"HTTPリダイレクト設定を変更しました。\", \"renewCertificateLoadingTitle\": \"証明書を更新しています...\", \"renewCertificateLoadingSubtitle\": \"このページを離れないでください。\"}, \"auth\": {\"title\": \"認証\", \"force2fa\": \"全ユーザーに2段階認証 (Two-Factor Authentication; 2FA) の使用を強制させる\", \"loginUrl\": \"ログインURL\", \"security\": \"セキュリティ\", \"subtitle\": \"ウィキの認証システムを設定します\", \"logoutUrl\": \"ログアウトURL\", \"strategies\": \"認証方式\", \"addStrategy\": \"認証方式を追加\", \"callbackUrl\": \"Callback URL / Redirect URL\", \"displayName\": \"表示名\", \"jwtAudience\": \"JWT Audience\", \"saveSuccess\": \"認証の設定を保存しました\", \"force2faHint\": \"ユーザーは最初にログインするときに2段階認証を設定する必要があります。ユーザーがこれを無効にすることはできません\", \"registration\": \"登録\", \"strategyState\": \"この認証方式は{{state}}{{locked}}\", \"refreshSuccess\": \"認証方式の一覧を更新しました\", \"configReference\": \"設定\", \"displayNameHint\": \"この認証方式のエンドユーザーに表示されるタイトル\", \"jwtAudienceHint\": \"ログイン時に発行される JWT で使われるAudience URN。通常はあなたのドメイン名を設定します (例: urn:your.domain.com)\", \"siteUrlNotSetup\": \"先に有効な{{siteUrl}}を設定する必要があります。左側のサイドバーの{{general}}をクリックしてください\", \"tokenExpiration\": \"トークンの有効期限\", \"activeStrategies\": \"有効化済みの認証方式\", \"autoEnrollGroups\": \"割り当てるグループ\", \"domainsWhitelist\": \"メールアドレスのドメインを特定のものに制限する\", \"selfRegistration\": \"自己登録を許可する\", \"allowedWebOrigins\": \"許可されている origin\", \"globalAdvSettings\": \"高度な設定\", \"strategyIsEnabled\": \"有効\", \"tokenRenewalPeriod\": \"トークンの更新期限\", \"strategyStateActive\": \"アクティブ\", \"strategyStateLocked\": \"で、無効化できません\", \"tokenExpirationHint\": \"トークンを更新しなければならなくなるまでの有効期間 (デフォルト: 30分)\", \"autoEnrollGroupsHint\": \"自動的に新しいユーザーをこれらのグループに割り当てます\", \"domainsWhitelistHint\": \"登録が許可されているドメインのリスト。アクセスするには、ユーザーのメールアドレスのドメインがこれらのいずれかと一致する必要があります\", \"selfRegistrationHint\": \"この認証方法で認証されたユーザーにウィキへのアクセスを許可します\", \"strategyConfiguration\": \"認証方式の設定\", \"strategyIsEnabledHint\": \"ユーザーにこの方式を使用したログインを許可しますか？\", \"strategyStateInactive\": \"非アクティブ\", \"tokenRenewalPeriodHint\": \"トークンの有効期限が切れたときに更新できる最大期間 (デフォルト: 14日)\", \"configReferenceSubtitle\": \"認証方式の中にはそれぞれのプロバイダでの設定を必要とするものがあります。これらはあくまで参考として記載されており、この認証方式には必要ないかもしれません\", \"strategyNoConfiguration\": \"この認証方式には変更可能な設定がありません\", \"tokenEndpointAuthMethod\": \"認証方式のトークンエンドポイント\"}, \"mail\": {\"dkim\": \"DKIM (任意)\", \"smtp\": \"SMTP設定\", \"test\": \"テスト用のメールを送信する\", \"title\": \"メール\", \"sender\": \"送信者\", \"dkimUse\": \"DKIMを使う\", \"smtpPwd\": \"パスワード\", \"smtpTLS\": \"安全な通信 (TLS)\", \"dkimHint\": \"DKIM (DomainKeysIdentified Mail) は、受信者がドメイン名を検証しメッセージの信頼性を確かめられるようにすることで、Wiki.js から送られるメールの安全性を高めます\", \"smtpHost\": \"ホスト\", \"smtpName\": \"クライアント識別ホスト名\", \"smtpPort\": \"ポート\", \"smtpUser\": \"ユーザー名\", \"subtitle\": \"メールに関するオプションを設定します\", \"testHint\": \"SMTP の設定が機能しているか確かめるため、テスト用のメールを送信します\", \"testSend\": \"メールを送信する\", \"senderName\": \"送信者名\", \"saveSuccess\": \"設定を保存しました\", \"senderEmail\": \"送信者のアドレス\", \"smtpTLSHint\": \"465番ポートを使用している場合はオンに、それ以外 (587か25) の場合はオフにします\", \"smtpNameHint\": \"SMTPサーバーに送信するメーカーを識別するための任意の名前。サーバーのホスト名を使用する場合は空欄のままにします。Google Workspaceを使用している場合はメインドメイン名に設定します。\", \"smtpPortHint\": \"通常は465 (推奨)、587、25のいずれかです\", \"configuration\": \"設定\", \"smtpVerifySSL\": \"SSL証明書の検証\", \"testRecipient\": \"受信者のメールアドレス\", \"dkimDomainName\": \"ドメイン名\", \"dkimPrivateKey\": \"秘密鍵\", \"dkimKeySelector\": \"キーセレクタ\", \"sendTestSuccess\": \"テスト用のメールを送信しました\", \"smtpVerifySSLHint\": \"一部のホストでは、SSL証明書のチェックを無効にする必要があります。適切なセキュリティのために有効のままにします。\", \"dkimPrivateKeyHint\": \"PEM形式のセレクタの秘密鍵\"}, \"tags\": {\"tag\": \"タグ\", \"date\": \"作成者 : {{created}}, 最終更新 : {{updated}}\", \"edit\": \"タグの編集\", \"label\": \"ラベル\", \"title\": \"タグ\", \"delete\": \"このタグを削除する\", \"filter\": \"フィルター...\", \"subtitle\": \"ページタグの管理\", \"emptyList\": \"表示するタグがありません。\", \"noItemsText\": \"開始するには、ページにタグを追加してください。\", \"saveSuccess\": \"タグを保存しました。\", \"deleteConfirm\": \"タグを削除しますか？\", \"deleteSuccess\": \"タグを削除しました。\", \"refreshSuccess\": \"タグが更新されました。\", \"noSelectionText\": \"左側のリストからタグを選択してください。\", \"viewLinkedPages\": \"リンクされたページを表示\", \"deleteConfirmText\": \"本当に {{tag}} タグを削除しますか？すべてのページからこのタグへのリンクが解除されます。\"}, \"pages\": {\"title\": \"ページ\"}, \"stats\": {\"title\": \"統計\"}, \"theme\": {\"title\": \"テーマ\", \"iconset\": \"アイコンセット\", \"options\": \"テーマオプション\", \"darkMode\": \"ダークモード\", \"subtitle\": \"ウィキの見た目を変更します\", \"siteTheme\": \"テーマ\", \"cssOverride\": \"CSSの上書き\", \"iconsetHint\": \"サイドバーナビゲーションに使用するアイコンのセット。\", \"darkModeHint\": \"アクセシビリティの観点では非推奨です。ダークモードをサポートしていないテーマもあります\", \"downloadName\": \"名前\", \"codeInjection\": \"追加コード\", \"siteThemeHint\": \"テーマはコンテンツページの表示方法に影響します。サイトの他の部分 (エディタや管理ページなど) には影響を与えません\", \"downloadAuthor\": \"作者\", \"downloadThemes\": \"テーマをダウンロード\", \"cssOverrideHint\": \"システムのデフォルトCSSの後に挿入されるCSSコードです。CSSのコードが多い場合には、カスタムテーマの使用を検討してください。あまりに多くのCSSコードを挿入しすぎるとページの読み込みパフォーマンスが低下します。CSSは自動的に最小化されます\", \"downloadDownload\": \"ダウンロード\", \"tocHeadingLevels\": \"目次のデフォルト見出しレベル\", \"bodyHtmlInjection\": \"body に挿入するHTMLコード\", \"headHtmlInjection\": \"head に挿入するHTMLコード\", \"cssOverrideWarning\": \"{{caution}} ページコンテンツにスタイルを追加する場合、スコープを{{cssClass}}クラス以下にする必要があります。これをしないとエディターのレイアウトが壊れる可能性があります。\", \"tocHeadingLevelsHint\": \"目次にはデフォルトで選択された見出しレベルが表示されます。\", \"bodyHtmlInjectionHint\": \"&lt;body&gt; タグが終了する直前に挿入されるHTMLコードです\", \"headHtmlInjectionHint\": \"&lt;head&gt; タグが終了する直前に挿入されるHTMLコードです。通常は &lt;script&gt; タグ用です\", \"cssOverrideWarningCaution\": \"注意:\"}, \"users\": {\"id\": \"ID {{id}}\", \"tfa\": \"2要素認証 (2FA)\", \"edit\": \"ユーザーを編集\", \"email\": \"メールアドレス\", \"title\": \"ユーザー\", \"active\": \"有効\", \"groups\": \"ユーザーグループ\", \"inactive\": \"無効\", \"jobTitle\": \"役職\", \"location\": \"場所\", \"password\": \"パスワード\", \"timezone\": \"タイムゾーン\", \"verified\": \"検証済\", \"basicInfo\": \"基本情報\", \"toggle2FA\": \"2FAを切り替え\", \"unverified\": \"未検証\", \"updateUser\": \"ユーザーを更新\", \"displayName\": \"表示名\", \"groupAssign\": \"割り当て\", \"newPassword\": \"新しいパスワード\", \"selectGroup\": \"グループを選択...\", \"authProvider\": \"プロバイダ\", \"authProviderId\": \"プロバイダ ID\", \"authentication\": \"認証\", \"changePassword\": \"パスワードを変更\", \"noGroupAssigned\": \"このユーザーはまだどのグループにも割り当てられていません。ユーザーには少なくとも1つのグループを割り当てる必要があります。\", \"extendedMetadata\": \"追加のメタデータ\", \"deleteConfirmText\": \"本当にユーザー {{username}} を削除しますか?\", \"groupAssignNotice\": \"この画面からユーザーを管理者やゲストのグループに割り当てることはできません。\", \"userUpdateSuccess\": \"ユーザーを更新しました\", \"userVerifySuccess\": \"ユーザーを確認しました。\", \"deleteConfirmTitle\": \"ユーザーを削除しますか？\", \"userActivateSuccess\": \"ユーザーを有効化しました。\", \"userTFAEnableSuccess\": \"2段階認証は正常に有効化されました。\", \"userDeactivateSuccess\": \"ユーザーを無効化しました。\", \"userTFADisableSuccess\": \"2段階認証は正常に無効化されました。\", \"deleteConfirmReplaceWarn\": \"このユーザーが作成したコンテンツ (ページ、ファイル、コメントなど) は、以下で選択したユーザーに割り当てられます。現在有効なユーザーに割り当てたくない場合は、ダミーのユーザー (削除済みユーザーなど) を作成することをお勧めします。\", \"deleteConfirmForeignNotice\": \"コンテンツを作成したユーザーは削除できません。代わりにユーザーを無効化するか、そのユーザーの作成したコンテンツをすべて削除する必要があります。\", \"userAlreadyAssignedToGroup\": \"ユーザーはすでにこのグループに割り当てられています。\"}, \"editor\": {\"title\": \"エディタ\"}, \"groups\": {\"title\": \"グループ\"}, \"locale\": {\"rtl\": \"RTL\", \"base\": {\"hint\": \"UIテキストは選択した言語で表示されます\", \"label\": \"サイトの言語\", \"labelWithNS\": \"基本言語\"}, \"code\": \"コード\", \"name\": \"名前\", \"title\": \"言語\", \"download\": \"ダウンロード\", \"settings\": \"言語設定\", \"sideload\": \"言語パッケージを手動で読み込む\", \"subtitle\": \"言語に関するオプションを設定します\", \"autoUpdate\": {\"hint\": \"この言語に対するアップデートを利用可能になり次第自動的にダウンロードします\", \"label\": \"自動的に更新する\", \"hintWithNS\": \"以下で有効になっている、名前空間を持つ全言語のアップデートを自動的にダウンロードします\"}, \"namespaces\": {\"hint\": \"同一ページで複数の言語のバージョンが使えるようにします\", \"label\": \"多言語名前空間\"}, \"nativeName\": \"現地語名\", \"namespacing\": \"多言語名前空間\", \"availability\": \"利用可能\", \"sideloadHelp\": \"インターネットに接続していない場合や、上記の方法で言語ファイルをダウンロードできない場合は、代わりに以下のパッケージをアップロードし手動で読み込むことができます\", \"downloadTitle\": \"言語をダウンロード\", \"activeNamespaces\": {\"hint\": \"多言語名前空間が有効になっている言語のリスト。上で定義された基本言語はこの選択に関わらず常に含まれます\", \"label\": \"アクティブな名前空間\"}, \"namespacingPrefixWarning\": {\"title\": \"言語コードがすべてのパスの前に付与されます (例: /{{langCode}}/page-name)\", \"subtitle\": \"言語コードがないパスは、上で定義した基本言語に自動的にリダイレクトされます\"}}, \"search\": {\"title\": \"検索エンジン\", \"subtitle\": \"ウィキの検索機能に関するオプションを設定します\", \"engineConfig\": \"エンジンの設定\", \"rebuildIndex\": \"インデックスの再構築\", \"searchEngine\": \"検索エンジン\", \"engineNoConfig\": \"このエンジンには変更可能な設定がありません\", \"configSaveSuccess\": \"検索エンジンの設定を保存しました\", \"listRefreshSuccess\": \"検索エンジンの一覧を更新しました\", \"indexRebuildSuccess\": \"インデックスを再構築しました\"}, \"system\": {\"os\": \"OS\", \"title\": \"システム情報\", \"cpuCores\": \"CPUコア数\", \"hostInfo\": \"ホスト\", \"hostname\": \"ホスト名\", \"ramUsage\": \"RAMの使用状況: {{used}} / {{total}}\", \"subtitle\": \"システムに関する情報を表示します\", \"totalRAM\": \"合計RAMサイズ\", \"published\": \"公開日\", \"configFile\": \"設定ファイル\", \"latestVersion\": \"最新バージョン\", \"currentVersion\": \"現在のバージョン\", \"refreshSuccess\": \"システム情報を更新しました\", \"dbPartialSupport\": \"お使いのデータベースのバージョンは完全にはサポートされていません。一部の機能が制限されていたり、期待通りに動作しない場合があります\", \"workingDirectory\": \"作業ディレクトリ\"}, \"general\": {\"logo\": \"ロゴ\", \"title\": \"全般設定\", \"editFab\": \"FABクイック編集メニュー\", \"general\": \"全般設定\", \"logoUrl\": \"ロゴURL\", \"siteUrl\": \"サイトのURL\", \"siteInfo\": \"サイト情報\", \"subtitle\": \"ウィキ全体に関わる主要なオプションを設定します\", \"siteTitle\": \"サイトのタイトル\", \"metaRobots\": \"クローラー設定\", \"uploadLogo\": \"アップロード\", \"companyName\": \"会社/組織名\", \"editFabHint\": \"画面右下にメニューボタン（FAB）を追加\", \"editMenuBar\": \"メニューバーを編集する\", \"logoUrlHint\": \"ロゴとして使用する画像を指定します。SVG, PNG, JPGがサポートされています。34x34ピクセル以上の正方形にしてください。右のボタンをクリックすると新しい画像をアップロードできます。\", \"saveSuccess\": \"サイト設定は正常に保存されました。\", \"siteUrlHint\": \"末尾のスラッシュを含まないウィキの完全なURL。例: https://wiki.example.com\", \"uploadClear\": \"削除\", \"siteBranding\": \"サイトのブランディング\", \"editShortcuts\": \"編集ショートカット\", \"siteTitleHint\": \"上部のバーに表示されます。各ページのタイトルにも付与されます\", \"contentLicense\": \"コンテンツライセンス\", \"footerOverride\": \"フッターテキストの上書き\", \"metaRobotsHint\": \"デフォルト: index、follow。ページ単位で設定することもできます\", \"pageExtensions\": \"ページ拡張機能\", \"uploadSizeHint\": \"{{size}} の画像を推奨します\", \"companyNameHint\": \"ページ下に表示される著作権情報です。空のままにすると非表示になります\", \"footerCopyright\": \"ページ下部に表示する著作権情報\", \"siteDescription\": \"サイトの説明\", \"uploadTypesHint\": \"{{typelist}}, {{lasttype}} のみ選択可能です\", \"contentLicenseHint\": \"ライセンスはすべてのページのフッターに表示されます。\", \"displayEditMenuBar\": \"編集メニューバーの表示\", \"displayEditMenuBtn\": \"編集ボタンを表示する\", \"footerOverrideHint\": \"必要に応じて、フッター テキストをカスタム メッセージで上書きします。上記のライセンスのいずれも適切でない場合に役立ちます。\", \"pageExtensionsHint\": \"ページとして扱うURL拡張子(コンマ区切り)。たとえば、mdを追加すると/foobar.mdは/foobarと同じように扱われます。\", \"editMenuExternalUrl\": \"ボタンURL\", \"siteDescriptionHint\": \"ページに何も指定されていない場合のデフォルトの説明\", \"editMenuExternalIcon\": \"ボタンアイコン\", \"editMenuExternalName\": \"ボタンのサイト名\", \"siteTitleInvalidChars\": \"サイトタイトルに無効な文字が含まれています。\", \"displayEditMenuBarHint\": \"ページヘッダーに編集メニューバーを表示する。\", \"displayEditMenuBtnHint\": \"現在のページを編集するためのボタンを表示する。\", \"editMenuExternalUrlHint\": \"外部リポジトリの URL。ファイル名を含める場合は {filename} を使用します。(例: https://github.com/foo/bar/blob/main/{filename} )\", \"editMenuExternalIconHint\": \"編集ボタンに表示されるアイコン。たとえば、GitHub アイコンを表示するには mdi-github と入力します。\", \"editMenuExternalNameHint\": \"編集ボタンに表示する外部サイトの名前。\\\"で編集\\\"の部分は含めないでください。\", \"displayEditMenuExternalBtn\": \"外部編集ボタンを表示する\", \"displayEditMenuExternalBtnHint\": \"ユーザーが現在のページのPRを編集または送信できる外部リポジトリ(GitHubなど)にリンクするボタンを表示する。\"}, \"logging\": {\"title\": \"ログ\"}, \"storage\": {\"title\": \"ストレージ\", \"status\": \"ステータス\", \"actions\": \"アクション\", \"targets\": \"ターゲット\", \"errorMsg\": \"エラーメッセージ\", \"lastSync\": \"最後の同期 {{time}}\", \"noTarget\": \"アクティブなストレージがありません\", \"subtitle\": \"コンテンツのバックアップと同期のターゲットを設定します\", \"actionRun\": \"実行\", \"syncDirBi\": \"双方向\", \"syncDirPull\": \"ターゲットから pull\", \"syncDirPush\": \"ターゲットへ push\", \"targetState\": \"このストレージターゲットは{{state}}です\", \"unsupported\": \"未サポート\", \"syncSchedule\": \"同期スケジュール\", \"targetConfig\": \"ターゲットの設定\", \"syncDirBiHint\": \"双方向モードでは、まずストレージからコンテンツを pull してきます。新しいコンテンツはローカルのコンテンツを上書きします。最後の同期以降に新しく増えたコンテンツはストレージに push され、ストレージ側にも同じコンテンツがあればそれを上書きします\", \"syncDirection\": \"同期の方向\", \"noConfigOption\": \"このターゲットには変更可能な設定がありません\", \"lastSyncAttempt\": \"最後の試行 {{time}}\", \"syncDirPullHint\": \"コンテンツを常にストレージから pull します。既存のローカルのコンテンツは上書きされます。これは通常使い捨てのコンテンツをインポートするためのものです。ローカルのコンテンツが常に上書きされることにご注意ください\", \"syncDirPushHint\": \"コンテンツを常にストレージへ push します。既存のコンテンツは上書きされます。バックアップ目的としてはもっとも安全な選択肢です\", \"syncScheduleHint\": \"パフォーマンス上の理由から、このストレージは変更のたびに毎回同期するのではなく決められた間隔で同期します。どれくらいの間隔で同期をおこなうかを設定します。\", \"targetStateActive\": \"有効\", \"actionsInactiveWarn\": \"アクションを実行する前にこのストレージターゲットを有効化してください。\", \"syncScheduleCurrent\": \"現在{{schedule}}ごとに設定されています\", \"syncScheduleDefault\": \"デフォルトでは{{schedule}}ごとです\", \"targetStateInactive\": \"無効\", \"syncDirectionSubtitle\": \"このストレージターゲットに対するコンテンツ同期の方法を選択してください\"}, \"comments\": {\"title\": \"コメント\", \"provider\": \"コメントシステム\", \"subtitle\": \"wikiのページにコメント欄を追加します\", \"providerConfig\": \"コメントシステムの設定\", \"providerNoConfig\": \"このコメントシステムには変更可能な設定がありません\", \"configSaveSuccess\": \"コメント設定は正常に保存されました。\"}, \"security\": {\"jwt\": \"JWT設定\", \"login\": \"ログイン\", \"title\": \"セキュリティ\", \"uploads\": \"アップロード\", \"subtitle\": \"セキュリティに関するオプションを設定します\", \"enforce2fa\": \"二段階認証を強制する\", \"loginBgUrl\": \"ログイン画面の背景画像URL\", \"bypassLogin\": \"ログイン画面をスキップ\", \"loginScreen\": \"ログイン画面\", \"uploadsInfo\": \"これらの設定はWiki.jsのみに影響します。リバースプロキシ (nginx, apache, Cloudflareなど) を使用している場合は、それらの設定と一致させる必要があります。\", \"loginSecurity\": \"セキュリティ\", \"maxUploadSize\": \"最大アップロードサイズ\", \"enforce2faHint\": \"ユーザー名 / パスワードフォームが表示される認証方式を使用している場合、すべてのユーザーに二段階認証の使用を強制します。\", \"hideLocalLogin\": \"ローカル認証方式を非表示にする\", \"loginBgUrlHint\": \"ログイン画面の背景画像を指定します。PNG, JPGがサポートされており、1920x1080ピクセルの画像が推奨されます。標準の画像を使用するには、空欄にしてください。新しく画像をアップロードするには、右側のボタンをクリックしてください。※ 選択した画像に対して、ゲストグループが読み込み権限を持つ必要があります。\", \"maxUploadBatch\": \"一回あたりの最大ファイル数\", \"bypassLoginHint\": \"ユーザーを一番目の認証方式に自動的にリダイレクトします。\", \"maxUploadSizeHint\": \"1ファイルあたりの最大サイズを指定します\", \"hideLocalLoginHint\": \"ログイン画面におけるローカル認証方式を非表示にします。一時的に使用したい場合は、URLに ?all を追加してください。\", \"maxUploadBatchHint\": \"一度にアップロードできる最大ファイル数を指定します\", \"maxUploadSizeSuffix\": \"バイト\", \"maxUploadBatchSuffix\": \"ファイル\"}, \"webhooks\": {\"title\": \"Webhook\", \"subtitle\": \"外部サービスへの webhook を管理します\"}, \"adminArea\": \"管理用エリア\", \"analytics\": {\"title\": \"アナリティクス\", \"subtitle\": \"ウィキにアナリティクスとトラッキングツールを導入します\", \"providers\": \"プロバイダ\", \"saveSuccess\": \"アナリティクスの設定を保存しました\", \"refreshSuccess\": \"プロバイダの一覧を更新しました\", \"providerConfiguration\": \"プロバイダ設定\", \"providerNoConfiguration\": \"このプロバイダには変更可能な設定がありません\"}, \"dashboard\": {\"pages\": \"ページ数\", \"title\": \"ダッシュボード\", \"users\": \"ユーザー数\", \"groups\": \"グループ数\", \"subtitle\": \"Wiki.js\", \"lastLogins\": \"最終ログイン\", \"versionNew\": \"新しいバージョンが利用可能です: {{version}}\", \"recentPages\": \"最近更新されたページ\", \"versionLatest\": \"このバージョンは最新版です\", \"contributeHelp\": \"あなたの力が必要です！\", \"mostPopularPages\": \"人気のページ\", \"contributeSubtitle\": \"Wiki.js はフリーのオープンソースプロジェクトです。このプロジェクトに貢献できる方法はいくつかあります\", \"contributeLearnMore\": \"もっと詳しく知る\"}, \"rendering\": {\"title\": \"レンダリング\", \"subtitle\": \"ページをレンダリングする際のパイプラインを設定します\"}, \"utilities\": {\"title\": \"ユーティリティ\", \"tools\": \"ツール\", \"subtitle\": \"メンテナンスおよびその他のツール\", \"authTitle\": \"認証\", \"cacheTitle\": \"キャッシュをクリア\", \"exportTitle\": \"ディスクにエクスポート\", \"authSubtitle\": \"認証/ユーザー用のさまざまなツール\", \"contentTitle\": \"コンテンツ\", \"cacheSubtitle\": \"さまざまなコンポーネントのキャッシュをクリアします\", \"importv1Title\": \"Wiki.js 1.x からインポート\", \"exportSubtitle\": \"バックアップ/移行のためにtarballでコンテンツを保存する\", \"telemetryTitle\": \"テレメトリ\", \"contentSubtitle\": \"さまざまなツール\", \"importv1Subtitle\": \"以前のバージョン1.xからデータを移行します\", \"telemetrySubtitle\": \"テレメトリを有効/無効にするか、クライアントIDをリセットします\", \"graphEndpointTitle\": \"GraphQL エンドポイント\", \"graphEndpointSubtitle\": \"Wiki.js の GraphQL エンドポイントを変更します\"}, \"contribute\": {\"shop\": \"Wiki.js ショップ\", \"title\": \"Wiki.js に貢献する\", \"github\": \"GitHub Sponsors を介してスポンサーになる (フルタイムで Wiki.js を開発しているリード開発者 Nicolas Giard に直接入ります)\", \"paypal\": \"Paypal で1度限りまたは繰り返し寄付をする\", \"patreon\": \"Patreon を介して後援者またはスポンサーになる (フルタイムで Wiki.js を開発している主任開発者 Nicolas Giard に直接入ります)\", \"tshirts\": \"プロジェクトを経済的にサポートするために Wiki.js のTシャツを購入することもできます\", \"ethereum\": \"Ethereum を使った寄付を受け付けています\", \"subtitle\": \"Wiki.js の開発と運営を支援する\", \"foundABug\": \"バグを見つけましたか？{{0}}に問題を報告してください\", \"contribute\": \"貢献する\", \"openSource\": \"Wiki.jsは、 {{1}}と{{2}}によって{{0}}と共に提供されるフリーのオープンソースソフトウェアです\", \"fundOurWork\": \"Wiki.js の開発を支援する\", \"needYourHelp\": \"ソフトウェアの改良を続け、関連するさまざまなサービス (ホスティングやネットワークなど) を運営するにはあなたの助けが必要です\", \"submitAnIdea\": \"{{0}}でアイデアを提案したり、提案されたアイデアに投票したりしましょう\", \"becomeAPatron\": \"パトロンになる\", \"helpTranslate\": \"Wiki.jsをあなたの言語に翻訳するのを手伝ってください。 {{0}}までご連絡ください\", \"makeADonation\": \"寄付する\", \"spreadTheWord\": \"世界に広める\", \"talkToFriends\": \"Wiki.js がどんなに素晴らしいか友人や同僚に話しましょう\", \"becomeASponsor\": \"スポンサーになる\", \"openCollective\": \"Wiki.js は Open Collective Initiative の一部でもあります。これは、コミュニティのリソースに向けた透明性のある基金です。毎月または1回限りの寄付をすることで、経済的に貢献することができます\", \"submitAnIdeaLink\": \"機能要望用の掲示板\", \"followUsOnTwitter\": \"{0}で私たちをフォローしてください\", \"openSourceContributors\": \"貢献者\"}, \"extensions\": {\"title\": \"拡張機能\", \"subtitle\": \"機能を追加するための拡張機能をインストールします\"}, \"navigation\": {\"edit\": \"{{kind}}を編集\", \"icon\": \"アイコン\", \"link\": \"リンク\", \"mode\": \"ナビゲーションモード\", \"label\": \"ラベル\", \"title\": \"ナビゲーション\", \"delete\": \"{{kind}}を削除\", \"header\": \"ヘッダー\", \"target\": \"ターゲット\", \"divider\": \"区切り線\", \"navType\": {\"home\": \"ホーム\", \"page\": \"ページ\", \"external\": \"外部リンク\", \"searchQuery\": \"検索\", \"externalblank\": \"外部リンク (新しいウィンドウ)\"}, \"modeNone\": {\"title\": \"なし\", \"description\": \"サイトナビゲーションを無効化する\"}, \"subtitle\": \"サイトのナビゲーションを管理します\", \"untitled\": \"無題の{{kind}}\", \"emptyList\": \"ナビゲーションは空です\", \"modeCustom\": {\"title\": \"カスタムナビゲーション\", \"description\": \"固定ナビゲーションメニュー+サイトツリーボタン\"}, \"modeStatic\": {\"title\": \"固定ナビゲーション\", \"description\": \"固定ナビゲーションのみ\"}, \"targetType\": \"ターゲットの種類\", \"noItemsText\": \"追加ボタンをクリックしてナビゲーションの項目を追加してください\", \"saveSuccess\": \"ナビゲーションを保存しました\", \"modeSiteTree\": {\"title\": \"サイトツリー\", \"description\": \"ツリー形式のナビゲーション(クラシック)\"}, \"sourceLocale\": \"コピー元言語\", \"copyFromLocale\": \"他の言語からコピー\", \"visibilityMode\": {\"all\": \"誰でも閲覧可能\", \"restricted\": \"閲覧可能にするグループを選択...\"}, \"noSelectionText\": \"左側のナビゲーション項目を選択してください\", \"selectPageButton\": \"ページを選択してください...\", \"sourceLocaleHint\": \"ナビゲーション項目のコピー元の言語\", \"copyFromLocaleInfoText\": \"どの言語から項目をコピーするか選択してください。現在有効化されている言語のナビゲーションに追加されます。\"}}, \"common\": {\"page\": {\"id\": \"ID {{id}}\", \"toc\": \"目次\", \"tags\": \"タグ\", \"share\": \"共有\", \"delete\": \"ページを削除\", \"global\": \"公開\", \"convert\": \"ページを変換\", \"loading\": \"ページを読み込み中...\", \"private\": \"非公開\", \"bookmark\": \"ブックマーク\", \"editPage\": \"ページを編集\", \"published\": \"公開\", \"versionId\": \"バージョンID {{id}}\", \"deleteTitle\": \"本当に{{title}}を削除しますか？\", \"printFormat\": \"印刷形式\", \"unpublished\": \"非公開\", \"convertTitle\": \"ページ「{{title}}」で今後使用したいエディターを選択：\", \"editExternal\": \"{{name}}で編集する\", \"lastEditedBy\": \"最終更新\", \"tagsMatching\": \"タグに一致するページ\", \"viewingSource\": \"{{path}}のソースを表示\", \"deleteSubtitle\": \"このページは管理ページから復旧可能です\", \"convertSubtitle\": \"ページの内容は、新しく選択したエディターの形式に変換されます。変換の結果、一部の書式やレンダリングされていない内容が失われることがあります。スナップショットがページ履歴に追加されるため、いつでも元に戻すことが出来ます。\", \"returnNormalView\": \"通常の画面へ戻る\", \"unpublishedWarning\": \"このページは公開されていません。\", \"viewingSourceVersion\": \"ページ{{path}}の{{date}}時点でのソースを表示しています\"}, \"user\": {\"search\": \"ユーザーを検索\", \"searchPlaceholder\": \"ユーザーを検索...\"}, \"error\": {\"unexpected\": \"予期せぬエラーが発生しました\"}, \"footer\": {\"license\": \"コンテンツは{{license}}の下で利用できます (by {{company}})。\", \"copyright\": \"{{year}} {{company}}. All rights reserved.\", \"poweredBy\": \"Powered by\"}, \"header\": {\"edit\": \"編集\", \"home\": \"ホーム\", \"move\": \"移動/名前の変更\", \"view\": \"閲覧\", \"admin\": \"管理画面\", \"login\": \"ログイン\", \"assets\": \"ファイル\", \"delete\": \"削除\", \"logout\": \"ログアウト\", \"myWiki\": \"個人用ウィキ\", \"search\": \"検索...\", \"account\": \"アカウント\", \"convert\": \"変換\", \"history\": \"履歴\", \"newPage\": \"新規作成\", \"profile\": \"プロフィール\", \"siteMap\": \"サイトマップ\", \"language\": \"言語\", \"duplicate\": \"複製\", \"browseTags\": \"タグ\", \"searchHint\": \"検索を始めるには少なくとも2文字を入力してください\", \"viewSource\": \"ソースを表示\", \"currentPage\": \"現在のページ\", \"imagesFiles\": \"画像とファイル\", \"pageActions\": \"ページアクション\", \"searchClose\": \"閉じる\", \"searchLoading\": \"検索中...\", \"searchCopyLink\": \"検索リンクをコピー\", \"searchNoResult\": \"一致するページがありません\", \"searchDidYouMean\": \"もしかして...\", \"searchResultsCount\": \"{{total}}件見つかりました\"}, \"actions\": {\"ok\": \"OK\", \"add\": \"追加\", \"copy\": \"コピー\", \"edit\": \"編集\", \"exit\": \"閉じる\", \"move\": \"移動\", \"page\": \"ページ\", \"save\": \"保存\", \"apply\": \"適用\", \"clear\": \"クリア\", \"close\": \"閉じる\", \"fetch\": \"取得\", \"browse\": \"参照…\", \"cancel\": \"キャンセル\", \"create\": \"作成\", \"delete\": \"削除\", \"insert\": \"挿入\", \"rename\": \"名前の変更\", \"select\": \"選択\", \"upload\": \"アップロード\", \"confirm\": \"確認\", \"convert\": \"変換\", \"discard\": \"破棄\", \"preview\": \"プレビュー\", \"proceed\": \"続行\", \"refresh\": \"更新\", \"download\": \"ダウンロード\", \"generate\": \"生成\", \"optimize\": \"最適化\", \"properties\": \"プロパティ\", \"returnToTop\": \"トップへ戻る\", \"saveChanges\": \"変更を保存\", \"discardChanges\": \"変更を破棄\"}, \"license\": {\"alr\": \"All Rights Reserved\", \"cc0\": \"パブリックドメイン\", \"ccby\": \"CCライセンス BY(表示)\", \"none\": \"なし\", \"ccbync\": \"CCライセンス BY-NC(表示-非営利)\", \"ccbynd\": \"CCライセンス BY-ND(表示-改変禁止)\", \"ccbysa\": \"CCライセンス BY-SA(表示-継承)\", \"ccbyncnd\": \"CCライセンス BY-NC-ND(表示-非営利-改変禁止)\", \"ccbyncsa\": \"CCライセンス BY-NC-SA(表示-非営利-継承)\"}, \"newpage\": {\"title\": \"このページはまだ存在しません\", \"create\": \"ページの作成\", \"goback\": \"戻る\", \"subtitle\": \"今すぐ作成しますか？\"}, \"sidebar\": {\"root\": \"(ルート)\", \"browse\": \"参照\", \"mainMenu\": \"メインメニュー\", \"currentDirectory\": \"現在のディレクトリ\"}, \"welcome\": {\"title\": \"あなたのウィキへようこそ！\", \"goadmin\": \"管理画面\", \"subtitle\": \"まずはホームページを作成してみましょう\", \"createhome\": \"ホームページの作成\"}, \"comments\": {\"none\": \"コメントはまだありません。\", \"title\": \"コメント\", \"beFirst\": \"最初のコメントを投稿しましょう。\", \"loading\": \"コメントを読込中...\", \"sdTitle\": \"コメント\", \"modified\": \"編集済み：{{reldate}}\", \"fieldName\": \"名前\", \"postingAs\": \"{{name}}として投稿\", \"deleteWarn\": \"このコメントを完全に削除してもよろしいですか？\", \"fieldEmail\": \"メールアドレス\", \"newComment\": \"新しいコメント\", \"postComment\": \"コメントを投稿\", \"postSuccess\": \"新しいコメントが正しく投稿されました。\", \"fieldContent\": \"コメント内容\", \"deleteSuccess\": \"コメントは正常に削除されました。\", \"updateComment\": \"コメントを更新\", \"updateSuccess\": \"コメントは正常に更新されました。\", \"markdownFormat\": \"Markdown記法\", \"newPlaceholder\": \"新しいコメントを投稿する...\", \"viewDiscussion\": \"コメント欄を表示\", \"deleteConfirmTitle\": \"削除の確認\", \"contentMissingError\": \"コメントが空欄であるか、短すぎます。\", \"deletePermanentWarn\": \"この変更は元に戻せません\"}, \"duration\": {\"days\": \"日\", \"every\": \"毎\", \"hours\": \"時間\", \"years\": \"年\", \"months\": \"月\", \"minutes\": \"分\"}, \"notfound\": {\"title\": \"見つかりません\", \"gohome\": \"ホーム\", \"subtitle\": \"このページは存在しません\"}, \"password\": {\"weak\": \"弱い\", \"strong\": \"強い\", \"average\": \"普通\", \"veryWeak\": \"非常に弱い\", \"veryStrong\": \"非常に強い\"}, \"pageSelector\": {\"pages\": \"ページ\", \"moveTitle\": \"ページの場所を移動・リネーム\", \"createTitle\": \"新しいページの場所を選択\", \"selectTitle\": \"ページを選択\", \"virtualFolders\": \"仮想フォルダ\", \"folderEmptyWarning\": \"このフォルダは空です。\"}, \"unauthorized\": {\"login\": \"ログイン...\", \"title\": \"未認証\", \"action\": {\"edit\": \"このページは編集できません\", \"view\": \"このページを見ることはできません\", \"create\": \"このページは作成できません\", \"source\": \"このページのソースを見ることはできません\", \"history\": \"このページの履歴を見ることはできません\", \"download\": \"ページのコンテンツをダウンロードすることはできません。\", \"sourceVersion\": \"このバージョンのページのソースは表示できません。\", \"downloadVersion\": \"このページバージョンのコンテンツはダウンロードできません。\"}, \"goback\": \"戻る\"}, \"modernBrowser\": \"最新のブラウザ\", \"outdatedBrowserWarning\": \"お使いのブラウザは古くなっています。 {{modernBrowser}}にアップグレードしてください。\"}, \"editor\": {\"page\": \"ページ\", \"save\": {\"error\": \"ページ作成中にエラーが発生しました\", \"saved\": \"保存しました\", \"pleaseWait\": \"しばらくお待ちください...\", \"processing\": \"処理中\", \"createSuccess\": \"ページを作成しました\", \"updateSuccess\": \"ページを更新しました\"}, \"props\": {\"css\": \"CSS\", \"toc\": \"目次\", \"html\": \"HTML\", \"info\": \"情報\", \"path\": \"パス\", \"tags\": \"タグ\", \"title\": \"タイトル\", \"locale\": \"言語\", \"social\": \"ソーシャル\", \"styles\": \"スタイル\", \"cssHint\": \"CSSは保存時に自動的に圧縮されます。styleタグで囲わずに、CSSコードのみを記述してください。\", \"scripts\": \"スクリプト\", \"htmlHint\": \"Javascriptコードは、HTMLスクリプトタグで囲む必要があります。\", \"pageInfo\": \"ページ情報\", \"pathHint\": \"先頭または末尾にスラッシュを含めないでください\", \"tagsHint\": \"タグでページを分類し、見つけやすくします\", \"tocTitle\": \"目次\", \"publishEnd\": \"公開終了日時\", \"scheduling\": \"予約\", \"allowRatings\": \"評価を許可\", \"publishStart\": \"公開開始日時\", \"publishState\": \"公開状態\", \"allowComments\": \"コメントを許可\", \"displayAuthor\": \"編集者情報を表示\", \"publishToggle\": \"公開\", \"tocUseDefault\": \"サイトのデフォルトを使用する\", \"categorization\": \"カテゴリー\", \"pageProperties\": \"ページのプロパティ\", \"publishEndHint\": \"公開終了日時を設定しない場合は空のままにします\", \"socialFeatures\": \"ソーシャル機能\", \"allowRatingsHint\": \"このページの評価を有効化します。\", \"publishStartHint\": \"公開開始日時を設定しない場合は空のままにします\", \"shortDescription\": \"簡単な説明\", \"tocHeadingLevels\": \"目次の見出しレベル\", \"allowCommentsHint\": \"このページでコメントを有効化します。\", \"displayAuthorHint\": \"ページ編集者を最終更新時刻とともに表示します。\", \"displaySharingBar\": \"共有ツールバーを表示\", \"publishToggleHint\": \"非公開のページは、このページの書き込み権限を持つユーザーに引き続き表示されます。\", \"pathCategorization\": \"パスとカテゴリー\", \"shortDescriptionHint\": \"タイトルの下に表示されます\", \"tocHeadingLevelsHint\": \"目次には選択したレベルの見出しが表示されます。\", \"displaySharingBarHint\": \"共有と印刷ボタンのツールバーを表示します。\"}, \"assets\": {\"title\": \"ファイル\", \"headerId\": \"ID\", \"fileCount\": \"{{count}}ファイル\", \"newFolder\": \"新しいフォルダ\", \"fetchImage\": \"URLから画像を取得\", \"folderName\": \"フォルダ名\", \"headerType\": \"種類\", \"imageAlign\": \"画像の配置\", \"deleteAsset\": \"ファイルを削除\", \"folderEmpty\": \"フォルダは空です\", \"headerAdded\": \"追加日時\", \"renameAsset\": \"ファイル名を変更\", \"uploadAssets\": \"ファイルをアップロード\", \"uploadFailed\": \"ファイルのアップロードに失敗しました\", \"deleteSuccess\": \"ファイルを削除しました\", \"headerActions\": \"アクション\", \"noUploadError\": \"先にアップロードするファイルを選択してください\", \"renameSuccess\": \"ファイル名を変更しました\", \"headerFileSize\": \"ファイルサイズ\", \"headerFilename\": \"ファイル名\", \"refreshSuccess\": \"ファイルの一覧を更新しました\", \"deleteAssetWarn\": \"この変更は元に戻せません\", \"deleteAssetConfirm\": \"本当にファイルを削除しますか？\", \"folderCreateSuccess\": \"フォルダを作成しました\", \"renameAssetSubtitle\": \"このファイルの新しい名前を入力してください\", \"uploadAssetsDropZone\": \"ファイルを参照またはここにドロップ...\", \"folderNameNamingRules\": \"フォルダ名は{{namingRules}}に従う必要があります\", \"folderNameNamingRulesLink\": \"命名規則\"}, \"markup\": {\"bold\": \"太字\", \"italic\": \"斜体\", \"heading\": \"見出し {{level}}\", \"subscript\": \"下付き文字\", \"blockquote\": \"引用\", \"inlineCode\": \"インラインコード\", \"insertLink\": \"リンクの挿入\", \"insertBlock\": \"ブロックの挿入\", \"keyboardKey\": \"キーボードキー\", \"orderedList\": \"順序付きリスト\", \"superscript\": \"上付き文字\", \"tableHelper\": \"表の入力\", \"insertAssets\": \"画像の挿入\", \"horizontalBar\": \"水平線\", \"insertDiagram\": \"図の挿入\", \"strikethrough\": \"取り消し線\", \"unorderedList\": \"順序無しリスト\", \"blockquoteInfo\": \"引用 (情報)\", \"blockquoteError\": \"引用 (エラー)\", \"insertCodeBlock\": \"コードブロックの挿入\", \"insertVideoAudio\": \"動画/音声の挿入\", \"noSelectionError\": \"最初にテキストを選択してください。\", \"toggleSpellcheck\": \"スペルチェックの切り替え\", \"blockquoteSuccess\": \"引用 (成功)\", \"blockquoteWarning\": \"引用 (警告)\", \"togglePreviewPane\": \"プレビュー画面を表示/非表示\", \"distractionFreeMode\": \"集中モード\", \"insertMathExpression\": \"数式の挿入\", \"markdownFormattingHelp\": \"マークダウン書式のヘルプ\"}, \"select\": {\"title\": \"このページにどのエディタを使用しますか？\", \"customView\": \"またはカスタムビューを作成。\", \"cannotChange\": \"ページを作成した後は変更できません\"}, \"unsaved\": {\"body\": \"保存されていない変更があります。本当にこのページを離れますか？これまでの変更は破棄されます\", \"title\": \"保存されていない変更を破棄しますか？\"}, \"ckeditor\": {\"stats\": \"{{chars}}文字, {{words}}単語\"}, \"conflict\": {\"title\": \"競合の解決\", \"warning\": \"競合が発生しました！他のユーザーがこのページを既に変更しています。\", \"editable\": \"(編集可能)\", \"readonly\": \"(読み取り専用)\", \"useLocal\": \"ローカルを使用\", \"whatToDo\": \"どのようにしたいですか？\", \"overwrite\": {\"title\": \"リモートバージョンで上書きしますか?\", \"editsLost\": \"現在の編集内容は失われます。\", \"description\": \"現在のバージョンを最新のリモートコンテンツで置き換えます。よろしいですか？ {{refEditsLost}}\"}, \"pageTitle\": \"タイトル：\", \"useRemote\": \"リモートを使用\", \"infoGeneric\": \"このページのより新しいバージョンが {{authorName}} によって保存されました。{{date}}\", \"localVersion\": \"ローカルバージョン {{refEditable}}\", \"useLocalHint\": \"パネル左側のコンテンツを使用します\", \"leftPanelInfo\": \"現在{{date}}時点のページを編集しています\", \"remoteVersion\": \"リモートバージョン {{refReadOnly}}\", \"useRemoteHint\": \"ローカルの変更を破棄して最新バージョンを使用します\", \"whatToDoLocal\": \"現在のローカルバージョンっを使用し、最新の変更を無視します。\", \"rightPanelInfo\": \"最終編集者 {{authorName}}, {{date}}\", \"whatToDoRemote\": \"最新のリモートバージョンを使用し、あなたの変更を破棄します。\", \"pageDescription\": \"説明:\", \"viewLatestVersion\": \"最新のバージョンを表示\"}, \"backToEditor\": \"エディタに戻る\", \"unsavedWarning\": \"保存されていない内容があります。編集画面から離れてもよろしいですか？\"}, \"history\": {\"restore\": {\"success\": \"バージョンを復元しました！\", \"confirmText\": \"このページのコンテンツを{{date}}時点の状態に復元してよろしいですか？このバージョンは履歴の一番上にコピーされ、新しいバージョンも引き続き保持されます。\", \"confirmTitle\": \"バージョンを復元しますか？\", \"confirmButton\": \"復元\"}}, \"profile\": {\"auth\": {\"title\": \"認証\", \"provider\": \"認証方式\", \"newPassword\": \"新しいパスワード\", \"changePassword\": \"パスワードを変更\", \"verifyPassword\": \"新しいパスワード (再入力)\", \"currentPassword\": \"現在のパスワード\", \"changePassSuccess\": \"パスワードは正常に変更されました。\"}, \"save\": {\"success\": \"プロフィールは正常に保存されました。\"}, \"pages\": {\"title\": \"ページ\", \"subtitle\": \"自分が作成・編集したページの一覧\", \"emptyList\": \"表示するページがありません。\", \"headerPath\": \"パス\", \"headerTitle\": \"タイトル\", \"refreshSuccess\": \"ページの一覧を更新しました。\", \"headerCreatedAt\": \"作成日時\", \"headerUpdatedAt\": \"最終更新\"}, \"title\": \"プロフィール\", \"groups\": {\"title\": \"グループ\"}, \"myInfo\": \"自分の情報\", \"activity\": {\"title\": \"アクティビティ\", \"joinedOn\": \"参加日時\", \"lastLoginOn\": \"最終ログイン\", \"pagesCreated\": \"ページ作成数\", \"lastUpdatedOn\": \"プロフィールの最終更新日時\", \"commentsPosted\": \"コメント投稿数\"}, \"comments\": {\"title\": \"コメント\"}, \"jobTitle\": \"役職\", \"location\": \"場所\", \"subtitle\": \"自分の個人情報\", \"timezone\": \"タイムゾーン\", \"appearance\": \"外観\", \"dateFormat\": \"日付形式\", \"displayName\": \"表示名\", \"preferences\": \"設定\", \"localeDefault\": \"言語のデフォルト\", \"appearanceDark\": \"ダーク\", \"appearanceLight\": \"ライト\", \"appearanceDefault\": \"サイトのデフォルト\", \"viewPublicProfile\": \"公開プロフィールを表示\"}}',0,'Japanese','日本語 (にほんご)',100,'2025-04-18T01:28:01.444Z','2025-04-18T01:30:00.333Z');
/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loggers`
--

DROP TABLE IF EXISTS `loggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loggers` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `level` varchar(255) NOT NULL DEFAULT 'warn',
  `config` json DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loggers`
--

LOCK TABLES `loggers` WRITE;
/*!40000 ALTER TABLE `loggers` DISABLE KEYS */;
INSERT INTO `loggers` VALUES ('airbrake',0,'warn','{}'),('bugsnag',0,'warn','{\"key\": \"\"}'),('disk',0,'info','{}'),('eventlog',0,'warn','{}'),('loggly',0,'warn','{\"token\": \"\", \"subdomain\": \"\"}'),('logstash',0,'warn','{}'),('newrelic',0,'warn','{}'),('papertrail',0,'warn','{\"host\": \"\", \"port\": 0}'),('raygun',0,'warn','{}'),('rollbar',0,'warn','{\"key\": \"\"}'),('sentry',0,'warn','{\"key\": \"\"}'),('syslog',0,'warn','{}');
/*!40000 ALTER TABLE `loggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `batch` int DEFAULT NULL,
  `migration_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2.0.0.js',1,'2025-04-17 16:26:54'),(2,'2.1.85.js',1,'2025-04-17 16:26:54'),(3,'2.2.3.js',1,'2025-04-17 16:26:54'),(4,'2.2.17.js',1,'2025-04-17 16:26:55'),(5,'2.3.10.js',1,'2025-04-17 16:26:55'),(6,'2.3.23.js',1,'2025-04-17 16:26:55'),(7,'2.4.13.js',1,'2025-04-17 16:26:55'),(8,'2.4.14.js',1,'2025-04-17 16:26:55'),(9,'2.4.36.js',1,'2025-04-17 16:26:55'),(10,'2.4.61.js',1,'2025-04-17 16:26:55'),(11,'2.5.1.js',1,'2025-04-17 16:26:55'),(12,'2.5.12.js',1,'2025-04-17 16:26:55'),(13,'2.5.108.js',1,'2025-04-17 16:26:55'),(14,'2.5.118.js',1,'2025-04-17 16:26:55'),(15,'2.5.122.js',1,'2025-04-17 16:26:56'),(16,'2.5.128.js',1,'2025-04-17 16:26:56');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations_lock`
--

DROP TABLE IF EXISTS `migrations_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations_lock` (
  `index` int unsigned NOT NULL AUTO_INCREMENT,
  `is_locked` int DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations_lock`
--

LOCK TABLES `migrations_lock` WRITE;
/*!40000 ALTER TABLE `migrations_lock` DISABLE KEYS */;
INSERT INTO `migrations_lock` VALUES (1,0);
/*!40000 ALTER TABLE `migrations_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation`
--

DROP TABLE IF EXISTS `navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation` (
  `key` varchar(255) NOT NULL,
  `config` json DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation`
--

LOCK TABLES `navigation` WRITE;
/*!40000 ALTER TABLE `navigation` DISABLE KEYS */;
INSERT INTO `navigation` VALUES ('site','[{\"items\": [{\"id\": \"4a488c96-6a5a-4718-86e2-287145d448cb\", \"icon\": \"mdi-home\", \"kind\": \"link\", \"label\": \"Home\", \"target\": \"/\", \"targetType\": \"home\", \"visibilityMode\": \"all\", \"visibilityGroups\": null}], \"locale\": \"en\"}]');
/*!40000 ALTER TABLE `navigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageHistory`
--

DROP TABLE IF EXISTS `pageHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pageHistory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isPrivate` tinyint(1) NOT NULL DEFAULT '0',
  `isPublished` tinyint(1) NOT NULL DEFAULT '0',
  `publishStartDate` varchar(255) DEFAULT NULL,
  `publishEndDate` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT 'updated',
  `pageId` int unsigned DEFAULT NULL,
  `content` longtext,
  `contentType` varchar(255) NOT NULL,
  `createdAt` varchar(255) NOT NULL,
  `editorKey` varchar(255) DEFAULT NULL,
  `localeCode` varchar(5) DEFAULT NULL,
  `authorId` int unsigned DEFAULT NULL,
  `versionDate` varchar(255) NOT NULL DEFAULT '',
  `extra` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagehistory_editorkey_foreign` (`editorKey`),
  KEY `pagehistory_localecode_foreign` (`localeCode`),
  KEY `pagehistory_authorid_foreign` (`authorId`),
  CONSTRAINT `pagehistory_authorid_foreign` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`),
  CONSTRAINT `pagehistory_editorkey_foreign` FOREIGN KEY (`editorKey`) REFERENCES `editors` (`key`),
  CONSTRAINT `pagehistory_localecode_foreign` FOREIGN KEY (`localeCode`) REFERENCES `locales` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageHistory`
--

LOCK TABLES `pageHistory` WRITE;
/*!40000 ALTER TABLE `pageHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageHistoryTags`
--

DROP TABLE IF EXISTS `pageHistoryTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pageHistoryTags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pageId` int unsigned DEFAULT NULL,
  `tagId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagehistorytags_pageid_foreign` (`pageId`),
  KEY `pagehistorytags_tagid_foreign` (`tagId`),
  CONSTRAINT `pagehistorytags_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pageHistory` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pagehistorytags_tagid_foreign` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageHistoryTags`
--

LOCK TABLES `pageHistoryTags` WRITE;
/*!40000 ALTER TABLE `pageHistoryTags` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageHistoryTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageLinks`
--

DROP TABLE IF EXISTS `pageLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pageLinks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `localeCode` varchar(5) NOT NULL,
  `pageId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagelinks_pageid_foreign` (`pageId`),
  KEY `pagelinks_path_localecode_index` (`path`,`localeCode`),
  CONSTRAINT `pagelinks_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageLinks`
--

LOCK TABLES `pageLinks` WRITE;
/*!40000 ALTER TABLE `pageLinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTags`
--

DROP TABLE IF EXISTS `pageTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pageTags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pageId` int unsigned DEFAULT NULL,
  `tagId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagetags_pageid_foreign` (`pageId`),
  KEY `pagetags_tagid_foreign` (`tagId`),
  CONSTRAINT `pagetags_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pagetags_tagid_foreign` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTags`
--

LOCK TABLES `pageTags` WRITE;
/*!40000 ALTER TABLE `pageTags` DISABLE KEYS */;
/*!40000 ALTER TABLE `pageTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pageTree`
--

DROP TABLE IF EXISTS `pageTree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pageTree` (
  `id` int unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `depth` int unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `isPrivate` tinyint(1) NOT NULL DEFAULT '0',
  `isFolder` tinyint(1) NOT NULL DEFAULT '0',
  `privateNS` varchar(255) DEFAULT NULL,
  `parent` int unsigned DEFAULT NULL,
  `pageId` int unsigned DEFAULT NULL,
  `localeCode` varchar(5) DEFAULT NULL,
  `ancestors` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagetree_parent_foreign` (`parent`),
  KEY `pagetree_pageid_foreign` (`pageId`),
  KEY `pagetree_localecode_foreign` (`localeCode`),
  CONSTRAINT `pagetree_localecode_foreign` FOREIGN KEY (`localeCode`) REFERENCES `locales` (`code`),
  CONSTRAINT `pagetree_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pagetree_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `pageTree` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pageTree`
--

LOCK TABLES `pageTree` WRITE;
/*!40000 ALTER TABLE `pageTree` DISABLE KEYS */;
INSERT INTO `pageTree` VALUES (1,'home',1,'HOME',0,0,NULL,NULL,1,'ja','[]');
/*!40000 ALTER TABLE `pageTree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isPrivate` tinyint(1) NOT NULL DEFAULT '0',
  `isPublished` tinyint(1) NOT NULL DEFAULT '0',
  `privateNS` varchar(255) DEFAULT NULL,
  `publishStartDate` varchar(255) DEFAULT NULL,
  `publishEndDate` varchar(255) DEFAULT NULL,
  `content` longtext,
  `render` longtext,
  `toc` json DEFAULT NULL,
  `contentType` varchar(255) NOT NULL,
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  `editorKey` varchar(255) DEFAULT NULL,
  `localeCode` varchar(5) DEFAULT NULL,
  `authorId` int unsigned DEFAULT NULL,
  `creatorId` int unsigned DEFAULT NULL,
  `extra` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pages_editorkey_foreign` (`editorKey`),
  KEY `pages_localecode_foreign` (`localeCode`),
  KEY `pages_authorid_foreign` (`authorId`),
  KEY `pages_creatorid_foreign` (`creatorId`),
  CONSTRAINT `pages_authorid_foreign` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`),
  CONSTRAINT `pages_creatorid_foreign` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`),
  CONSTRAINT `pages_editorkey_foreign` FOREIGN KEY (`editorKey`) REFERENCES `editors` (`key`),
  CONSTRAINT `pages_localecode_foreign` FOREIGN KEY (`localeCode`) REFERENCES `locales` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'home','0f734788eadaafa730c75cf2b4e4982dbeac4ceb','HOME','',0,1,NULL,'','','# Header\nYour content here','<h1 class=\"toc-header\" id=\"header\"><a href=\"#header\" class=\"toc-anchor\">¶</a> Header</h1>\n<p>Your content here</p>\n','[{\"title\": \"Header\", \"anchor\": \"#header\", \"children\": []}]','markdown','2025-04-18T01:28:59.039Z','2025-04-18T01:29:01.332Z','markdown','ja',1,1,'{\"js\": \"\", \"css\": \"\"}');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renderers`
--

DROP TABLE IF EXISTS `renderers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `renderers` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renderers`
--

LOCK TABLES `renderers` WRITE;
/*!40000 ALTER TABLE `renderers` DISABLE KEYS */;
INSERT INTO `renderers` VALUES ('asciidocCore',1,'{\"safeMode\": \"server\"}'),('htmlAsciinema',0,'{}'),('htmlBlockquotes',1,'{}'),('htmlCodehighlighter',1,'{}'),('htmlCore',1,'{\"absoluteLinks\": false, \"openExternalLinkNewTab\": false, \"relAttributeExternalLink\": \"noreferrer\"}'),('htmlDiagram',1,'{}'),('htmlImagePrefetch',0,'{}'),('htmlMediaplayers',1,'{}'),('htmlMermaid',1,'{}'),('htmlSecurity',1,'{\"safeHTML\": true, \"allowIFrames\": false, \"allowDrawIoUnsafe\": true}'),('htmlTabset',1,'{}'),('htmlTwemoji',1,'{}'),('markdownAbbr',1,'{}'),('markdownCore',1,'{\"quotes\": \"English\", \"linkify\": true, \"allowHTML\": true, \"underline\": false, \"linebreaks\": true, \"typographer\": false}'),('markdownEmoji',1,'{}'),('markdownExpandtabs',1,'{\"tabWidth\": 4}'),('markdownFootnotes',1,'{}'),('markdownImsize',1,'{}'),('markdownKatex',1,'{\"useBlocks\": true, \"useInline\": true}'),('markdownKroki',0,'{\"server\": \"https://kroki.io\", \"openMarker\": \"```kroki\", \"closeMarker\": \"```\"}'),('markdownMathjax',0,'{\"useBlocks\": true, \"useInline\": true}'),('markdownMultiTable',0,'{\"rowspanEnabled\": true, \"multilineEnabled\": true, \"headerlessEnabled\": true}'),('markdownPivotTable',0,'{}'),('markdownPlantuml',1,'{\"server\": \"https://plantuml.requarks.io\", \"openMarker\": \"```plantuml\", \"closeMarker\": \"```\", \"imageFormat\": \"svg\"}'),('markdownSupsub',1,'{\"subEnabled\": true, \"supEnabled\": true}'),('markdownTasklists',1,'{}'),('openapiCore',1,'{}');
/*!40000 ALTER TABLE `renderers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchEngines`
--

DROP TABLE IF EXISTS `searchEngines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searchEngines` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `config` json DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchEngines`
--

LOCK TABLES `searchEngines` WRITE;
/*!40000 ALTER TABLE `searchEngines` DISABLE KEYS */;
INSERT INTO `searchEngines` VALUES ('algolia',0,'{\"appId\": \"\", \"apiKey\": \"\", \"indexName\": \"wiki\"}'),('aws',0,'{\"domain\": \"\", \"region\": \"us-east-1\", \"endpoint\": \"\", \"accessKeyId\": \"\", \"secretAccessKey\": \"\", \"AnalysisSchemeLang\": \"en\"}'),('azure',0,'{\"adminKey\": \"\", \"indexName\": \"wiki\", \"serviceName\": \"\"}'),('db',1,'{}'),('elasticsearch',0,'{\"hosts\": \"\", \"analyzer\": \"simple\", \"indexName\": \"wiki\", \"apiVersion\": \"7.x\", \"tlsCertPath\": \"\", \"sniffOnStart\": false, \"sniffInterval\": 0, \"verifyTLSCertificate\": true}'),('manticore',0,'{}'),('postgres',0,'{\"dictLanguage\": \"english\"}'),('solr',0,'{\"core\": \"wiki\", \"host\": \"solr\", \"port\": 8983, \"protocol\": \"http\"}'),('sphinx',0,'{}');
/*!40000 ALTER TABLE `searchEngines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `sid` varchar(255) NOT NULL,
  `sess` json NOT NULL,
  `expired` datetime NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `sessions_expired_index` (`expired`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `key` varchar(255) NOT NULL,
  `value` json DEFAULT NULL,
  `updatedAt` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('auth','{\"audience\": \"urn:wiki.js\", \"tokenRenewal\": \"14d\", \"tokenExpiration\": \"30m\"}','2025-04-18T01:27:15.424Z'),('certs','{\"jwk\": {\"e\": \"AQAB\", \"n\": \"oD08Y4T3ZQDpLkSEtsNS4aKpxjaKaNnA-df6rLVZ6RQi3pDLT108qBRjueGDJ6YrBtfqmT-PGPmEiyZB2TtPhnxEty86DensIfDIUCi5Mn-D45AnfU3LosS0HVp-TcuoGYsnBmW3tYMBJvjYyte8kJr_qrGZru7gLxgrh09tKrkzFbeV7H8JSCF-PZd_W5zIX4Ebz0Y3tkPvlbZ2EbFBa2NBDb5oS35JeUe1OBuh0z8l8ieyqy7_VYbqqHv1tfaRcGKbjNKQzgnyfXytNwwDyMPJP9neq-4qIvapi9rW5N1HcsoLxrhBihmCG-OhqCCXQBONX0Jxa3GhuLRwnytV1Q\", \"kty\": \"RSA\"}, \"public\": \"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAoD08Y4T3ZQDpLkSEtsNS4aKpxjaKaNnA+df6rLVZ6RQi3pDLT108\\nqBRjueGDJ6YrBtfqmT+PGPmEiyZB2TtPhnxEty86DensIfDIUCi5Mn+D45AnfU3L\\nosS0HVp+TcuoGYsnBmW3tYMBJvjYyte8kJr/qrGZru7gLxgrh09tKrkzFbeV7H8J\\nSCF+PZd/W5zIX4Ebz0Y3tkPvlbZ2EbFBa2NBDb5oS35JeUe1OBuh0z8l8ieyqy7/\\nVYbqqHv1tfaRcGKbjNKQzgnyfXytNwwDyMPJP9neq+4qIvapi9rW5N1HcsoLxrhB\\nihmCG+OhqCCXQBONX0Jxa3GhuLRwnytV1QIDAQAB\\n-----END RSA PUBLIC KEY-----\\n\", \"private\": \"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,9CE5B21B08CBE7115E30BF251A3ADDA2\\n\\n+5oizz0PoIoj5AXy4m8HgL8173pCze9ro04Aa536qHJ779Fe7KcjD9I7Aa74cbog\\n7tkGU/4Hd4jF6xhzgPOrFuD+WzJWyqXooKXLoGHavZ+CXqSdlMB4ix4UFyL09BA1\\nzP8U/90LgwqoewZmQh4vParhB3daL4r1yN50Hi/Jo3BZW4XUxo3rIxrXgFhnQ5gk\\nl1pHpLVsS9B6udupN5dpa5XbaBpqL93fGYaC3JEQ8aRdIemU2zOInP8NWwj6BNYg\\nyk3Etv34Vey7zyNK/A3X4iB9HyMI2htCPBDvfbKINIULgf4IkykMGNaeniBFD5Hu\\nzIo1XbxLF+Md/25BCzDDeypNYMz35G57ur1KXX+dm3n3E65OWPY0kmwjwl3HJxBb\\nP3EldtycN4JtaJBlNm0L0DHPRQAboHPzsxjIFXnuvM8pbpGxJkvgTZ2bhRwW1QN2\\nMoaz0mlKy953J6Coe+TolpCQnjOnYqhd7uEXa7hVwe8XuvLMU7mGUdVa/x/dSmXF\\ndFemzOb4SQwvm2JcFmAL3ZSsid93WGTKYNFPG0Fz9k6inmqNIE5WrTFskefUrJKz\\nItF3wf1NYbtvBd0MZAOBszOpkMGIu6T8ccZysjzCxQGwiJBYPnVngii/UdreE2nn\\n72I+4bZLnhPh5CsAk0ja/0B2Uf3927u6A7fbkkZnnqDIZxwcWq7sxbfn92jErfIG\\n0rkmMX4Gf+H1oZ5YDgfMqUAqVvASqfzA6sdRRRFje6BAFG/t9wobUNoKzo8cuYqf\\nlNM26SvjZTCXlKs5xrUfQMs+P1C6+j9a2wyuy7BAQwaPu17W9Ol0lwB88Ja5Kdd0\\nAF0btEBAB67y1bYxdJXHZ87tGJqNQPgORp1KQAL0mVlm1wyzpKTboTA2vc9kZWyv\\nzdi3yM5ePQuNHvv4yiojz49C2HahfmdQaxlAoJnsv2jYofzp33hVW5DgeCXri4+e\\nb6zSqCaqzxPqQPxfO3bteLn8B+tQMtxjWzZD6kz9bXqHrwLDrAheiUKiVhhgc8E7\\nIzrHvHqTZlnxlOw/82QJnBkU3z8bLGo+toD1jIT2z/OAnqOTqQFa7ipfly/4xsVf\\nYgPikNseZAsKUGxfNSIEg3FroodJ2Bshy/yoKASWI7wv9hnmAI2EehgJ5S/kknnG\\n6vdFfTaB0NZ5z8yNR+4YdhHOhLprdrhqrb+igizT5HVq+JZmRmUse5pNbfoEQWGF\\nNn3xq6WM62Be3TLYAIPx4L9Wg8D8Xxj65AoSiX1Lt8k6i5+3L/uuqJkIjwTc7bCM\\nfZ+RkgTEQ3TifVSiJSPf2EoBOjgbSdtWfjhIx6xAY9JlMHlMYwUgKu1Xc47DJw9e\\nziZsWKdAKm3ggjBpCBw8dSUKOMfVktl8z4TB96n7HZRP59ud+7E+pVjFjj/I6bGy\\n5JNqtYtstC0OVtcvwDqEBMyRgBJQhP8r7/MvWJFz/ByiU9Diz4jAG3bpwB85fJSK\\nNw6NWAUQR81r+71BDUYPNsN91aoNBSTRarjqv5OrhF1neZqFRXmS7iiSKcoLgYhp\\nlpu7IiQd/RKZvePw92fwI6Gg9+VFV64E972oQJxQ9rAi3vbBf/c0jY/aNW33lJb7\\n-----END RSA PRIVATE KEY-----\\n\"}','2025-04-18T01:27:15.435Z'),('company','{\"v\": \"\"}','2025-04-18T01:27:15.444Z'),('features','{\"featurePageRatings\": true, \"featurePageComments\": true, \"featurePersonalWikis\": true}','2025-04-18T01:27:15.452Z'),('graphEndpoint','{\"v\": \"https://graph.requarks.io\"}','2025-04-18T01:27:15.460Z'),('host','{\"v\": \"https://wiki.yourdomain.com\"}','2025-04-18T01:27:15.479Z'),('lang','{\"rtl\": false, \"code\": \"ja\", \"autoUpdate\": true, \"namespaces\": [\"ja\"], \"namespacing\": false}','2025-04-18T01:28:05.720Z'),('logo','{\"hasLogo\": false, \"logoIsSquare\": false}','2025-04-18T01:27:15.493Z'),('mail','{\"host\": \"\", \"name\": \"\", \"pass\": \"\", \"port\": 465, \"user\": \"\", \"secure\": true, \"useDKIM\": false, \"verifySSL\": true, \"senderName\": \"\", \"senderEmail\": \"\", \"dkimDomainName\": \"\", \"dkimPrivateKey\": \"\", \"dkimKeySelector\": \"\"}','2025-04-18T01:27:15.501Z'),('seo','{\"robots\": [\"index\", \"follow\"], \"analyticsId\": \"\", \"description\": \"\", \"analyticsService\": \"\"}','2025-04-18T01:27:15.506Z'),('sessionSecret','{\"v\": \"3e0a8ca96f82e4791888150d67e1b7caf5924e5f3b18c6635eaba4ca57645eda\"}','2025-04-18T01:27:15.513Z'),('telemetry','{\"clientId\": \"dd700ecd-1bc1-4a08-b5d7-2a76e10233dc\", \"isEnabled\": true}','2025-04-18T01:27:15.520Z'),('theming','{\"theme\": \"default\", \"iconset\": \"mdi\", \"darkMode\": false, \"injectCSS\": \"\", \"injectBody\": \"\", \"injectHead\": \"\"}','2025-04-18T01:27:15.525Z'),('title','{\"v\": \"Wiki.js\"}','2025-04-18T01:27:15.538Z'),('uploads','{\"scanSVG\": true, \"maxFiles\": 10, \"maxFileSize\": 5242880, \"forceDownload\": true}','2025-04-18T01:27:15.531Z');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage` (
  `key` varchar(255) NOT NULL,
  `isEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `mode` varchar(255) NOT NULL DEFAULT 'push',
  `config` json DEFAULT NULL,
  `syncInterval` varchar(255) DEFAULT NULL,
  `state` json DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage`
--

LOCK TABLES `storage` WRITE;
/*!40000 ALTER TABLE `storage` DISABLE KEYS */;
INSERT INTO `storage` VALUES ('azure',0,'push','{\"accountKey\": \"\", \"accountName\": \"\", \"storageTier\": \"Cool\", \"containerName\": \"wiki\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('box',0,'push','{\"clientId\": \"\", \"rootFolder\": \"\", \"clientSecret\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('digitalocean',0,'push','{\"bucket\": \"\", \"endpoint\": \"nyc3.digitaloceanspaces.com\", \"accessKeyId\": \"\", \"secretAccessKey\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('disk',0,'push','{\"path\": \"\", \"createDailyBackups\": false}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('dropbox',0,'push','{\"appKey\": \"\", \"appSecret\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('gdrive',0,'push','{\"clientId\": \"\", \"clientSecret\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('git',1,'sync','{\"branch\": \"main\", \"repoUrl\": \"git@gitlab.com:k2works/wiki-pragmatic-programing-exercise.git\", \"authType\": \"ssh\", \"verifySSL\": true, \"defaultName\": \"John Smith\", \"defaultEmail\": \"name@company.com\", \"basicPassword\": \"\", \"basicUsername\": \"\", \"gitBinaryPath\": \"\", \"localRepoPath\": \"./data/repo\", \"alwaysNamespace\": false, \"sshPrivateKeyMode\": \"contents\", \"sshPrivateKeyPath\": \"\", \"sshPrivateKeyContent\": \"-----BEGIN OPENSSH PRIVATE KEY-----\\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn\\nNhAAAAAwEAAQAAAYEA3+boMswcXFUGmIf1J/YFf4GkzqscuhipDRJYfyjcQCgrF8eV3tgX\\nScn5fYukgHdEHg+CpHv0nhKtma17vJferZcU5iXcyOaFP2IxswIzFbh7Ker6m9Vr+8vC6O\\nYi1ilMtXDB62Pdp8D20cezvqKI+aSCfT2s/Bj8kaeaalKuoBzca/reI9rK3az7xwAs+NW6\\nriHRb+ZcopKRkMkWqR16EguaPd/rxAIAC3mpljCmQKUsgYX1POA/9KwRuohKD2I6gC6OM8\\n2o/c3bPiDiTGJMntGJ9Aj9Rn+lN+2Gj34IzCcF7v61NANDuPbfpVsa4nYTtOtcvscJQGR3\\nqyIy224ZAA8FXvO+Yz7dgmVR+YXyKUgLwVnrERrSB2ee2+iCCnplwbQO23U0jOfnMiDQe3\\nA0DU6OVJ7nSp1HabHdELfWhhNCXfgladXy2TQuJEatIaAg6Iie5ZakOXmtdwbXBqljX13k\\nr9ko4U2/ixWFXXPanhpApbgnX2/XiwiExcOhQvI3AAAFkPv8a1/7/GtfAAAAB3NzaC1yc2\\nEAAAGBAN/m6DLMHFxVBpiH9Sf2BX+BpM6rHLoYqQ0SWH8o3EAoKxfHld7YF0nJ+X2LpIB3\\nRB4PgqR79J4SrZmte7yX3q2XFOYl3MjmhT9iMbMCMxW4eynq+pvVa/vLwujmItYpTLVwwe\\ntj3afA9tHHs76iiPmkgn09rPwY/JGnmmpSrqAc3Gv63iPayt2s+8cALPjVuq4h0W/mXKKS\\nkZDJFqkdehILmj3f68QCAAt5qZYwpkClLIGF9TzgP/SsEbqISg9iOoAujjPNqP3N2z4g4k\\nxiTJ7RifQI/UZ/pTftho9+CMwnBe7+tTQDQ7j236VbGuJ2E7TrXL7HCUBkd6siMttuGQAP\\nBV7zvmM+3YJlUfmF8ilIC8FZ6xEa0gdnntvoggp6ZcG0Dtt1NIzn5zIg0HtwNA1OjlSe50\\nqdR2mx3RC31oYTQl34JWnV8tk0LiRGrSGgIOiInuWWpDl5rXcG1wapY19d5K/ZKOFNv4sV\\nhV1z2p4aQKW4J19v14sIhMXDoULyNwAAAAMBAAEAAAGBAN17sAPXztIzNZQbIZLHFkc8Oo\\nhJ0d/w1wFcPXiENeOtGHusbf+DqP3QMuFTCoYd9J773tLQ33iip2GWsAkt/hOfmQfVOmLt\\nTbAWdW1LZrc8x3D+xarzYp8wv/zc8mcBcaUmBl3Qawovorh/oLmaVH8GkiJLqVuzZ9y5e9\\nFjOuSdyBl0jtvO6dCA9oqzDMmVutXYFDJqIQackCw2Dxl5VDCXk5tTbwh0phCz5+Lu+vaF\\nrdHubloqxnlE4UCw4vn2wmclMvsn9OzDYc/spmSBLvtNo2pTD3Un2cxvQ9Ro217lIZZvIE\\nyCbRSL4ngK5tvpBcdM5Nqf6i05i8U03IG8Dgg7iun1CbA7uZ+M2dsaZfNuY/xYp5/OMYcL\\nBHYY1YonQJhvWR4qmYu74WUxTrbWKu+Fjk1wJSb6jGAEQj56WbD3g2WrYcvVsbmiAXhwbL\\nso3a7MT5bs1kYdoltxY0AfsWdl5u5hBP9Oc+jvK/BXiOl49B8yG1JoPJvvrszJOHzkaQAA\\nAMEAjRL/2bogyMreEfDgNkXZ1XCwdJdpGeew+0WvBayCFzbLALuuIKDLt8iTgcsHaQ812U\\n+5v/r7urXlLiY+b8W8k9mAceDD9pcTXxlOo/YhS86Vyq8i1ev9k6XAybG9qj4OQLj8isXy\\nUwHNGblheeFpiJmAX+JFkrJJgVH8xMmhxDTazbwuFx9WIVrZVq7ZZ7kZRi1n2tT7KxcWUc\\nw3UtGOMzIY7hBkGhHNU3cSKlTZWr3fe75xv/tOMmw4WFMS/GYWAAAAwQD/6vpVqwhZOQti\\n4pWy4J87NIX0Q99PCJTi7wZPtAm45qXXFrAWV1ADCzUaGZmvvWHSjqjOCyMTX5S0zfO+b5\\n1yHlXNFJTLoB+j4a6BZCCebRFpDGIu8XSZfO8M0c6YA9rh4s+F1rDo/K7k98oFEIMV3BGe\\npP82FtyvqHfPFyRs3tdPqrTitsz2+K94AlECgh+U0sW8xqsziRTmUjUmt6/2xGFat1Ndcy\\npREge26zho2mPBotjaqeFcbqOsWdGJLNUAAADBAN/5TJr5NSwOpsR16uJ9qdFDN0dtilJ/\\nKLwaMXaHfJ0z2wjex93iD43YBUXllW/NgKkY4Xr78DunlUoQ31TgQEwAALl/pipipxBBiY\\nJ8J/m61yxuvJuMiPnx3B1VfzxIHek0OiK/TXsC0Ve+jYIwcLNFtz2gFWyhCOJB1uCuXKv2\\nhL4PDMJfSnfxOHHfMY78W48+RIYWJJ1f6IFmnrvB0aUDDHaROMKddjX4PbVuTTuQb9G1VP\\nICFDFPEL+JlC842wAAABVwYzIwMjQxMS0xQFBDMjAyNDExLTEBAgME\\n-----END OPENSSH PRIVATE KEY-----\"}','PT5M','{\"status\": \"operational\", \"message\": \"\", \"lastAttempt\": \"2025-04-18T01:30:00.795Z\"}'),('onedrive',0,'push','{\"clientId\": \"\", \"clientSecret\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('s3',0,'push','{\"bucket\": \"\", \"region\": \"\", \"accessKeyId\": \"\", \"secretAccessKey\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('s3generic',0,'push','{\"bucket\": \"\", \"endpoint\": \"https://service.region.example.com\", \"sslEnabled\": true, \"accessKeyId\": \"\", \"secretAccessKey\": \"\", \"s3BucketEndpoint\": false, \"s3ForcePathStyle\": false}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}'),('sftp',0,'push','{\"host\": \"\", \"port\": 22, \"authMode\": \"privateKey\", \"basePath\": \"/root/wiki\", \"password\": \"\", \"username\": \"\", \"passphrase\": \"\", \"privateKey\": \"\"}','P0D','{\"status\": \"pending\", \"message\": \"Initializing...\", \"lastAttempt\": null}');
/*!40000 ALTER TABLE `storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_tag_unique` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userAvatars`
--

DROP TABLE IF EXISTS `userAvatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userAvatars` (
  `id` int NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userAvatars`
--

LOCK TABLES `userAvatars` WRITE;
/*!40000 ALTER TABLE `userAvatars` DISABLE KEYS */;
/*!40000 ALTER TABLE `userAvatars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userGroups`
--

DROP TABLE IF EXISTS `userGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userGroups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned DEFAULT NULL,
  `groupId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usergroups_userid_foreign` (`userId`),
  KEY `usergroups_groupid_foreign` (`groupId`),
  CONSTRAINT `usergroups_groupid_foreign` FOREIGN KEY (`groupId`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userGroups`
--

LOCK TABLES `userGroups` WRITE;
/*!40000 ALTER TABLE `userGroups` DISABLE KEYS */;
INSERT INTO `userGroups` VALUES (1,1,1),(2,2,2);
/*!40000 ALTER TABLE `userGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userKeys`
--

DROP TABLE IF EXISTS `userKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userKeys` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kind` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `createdAt` varchar(255) NOT NULL,
  `validUntil` varchar(255) NOT NULL,
  `userId` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userkeys_userid_foreign` (`userId`),
  CONSTRAINT `userkeys_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userKeys`
--

LOCK TABLES `userKeys` WRITE;
/*!40000 ALTER TABLE `userKeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `userKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `providerId` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tfaIsActive` tinyint(1) NOT NULL DEFAULT '0',
  `tfaSecret` varchar(255) DEFAULT NULL,
  `jobTitle` varchar(255) DEFAULT '',
  `location` varchar(255) DEFAULT '',
  `pictureUrl` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT 'America/New_York',
  `isSystem` tinyint(1) NOT NULL DEFAULT '0',
  `isActive` tinyint(1) NOT NULL DEFAULT '0',
  `isVerified` tinyint(1) NOT NULL DEFAULT '0',
  `mustChangePwd` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` varchar(255) NOT NULL,
  `updatedAt` varchar(255) NOT NULL,
  `providerKey` varchar(255) NOT NULL DEFAULT 'local',
  `localeCode` varchar(5) NOT NULL DEFAULT 'en',
  `defaultEditor` varchar(255) NOT NULL DEFAULT 'markdown',
  `lastLoginAt` varchar(255) DEFAULT NULL,
  `dateFormat` varchar(255) NOT NULL DEFAULT '',
  `appearance` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_providerkey_email_unique` (`providerKey`,`email`),
  KEY `users_localecode_foreign` (`localeCode`),
  KEY `users_defaulteditor_foreign` (`defaultEditor`),
  CONSTRAINT `users_defaulteditor_foreign` FOREIGN KEY (`defaultEditor`) REFERENCES `editors` (`key`),
  CONSTRAINT `users_localecode_foreign` FOREIGN KEY (`localeCode`) REFERENCES `locales` (`code`),
  CONSTRAINT `users_providerkey_foreign` FOREIGN KEY (`providerKey`) REFERENCES `authentication` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'kakimomokuri@gmail.com','Administrator',NULL,'$2a$12$XbX0p.UKVD/04dBiulrYHO.kmjrX9jocKhslOeyzP89Q8.8xg6I6S',0,NULL,'','',NULL,'America/New_York',0,1,1,0,'2025-04-18T01:27:15.893Z','2025-04-18T01:27:15.893Z','local','en','markdown','2025-04-18T01:27:43.709Z','',''),(2,'guest@example.com','Guest',NULL,'',0,NULL,'','',NULL,'America/New_York',1,1,1,0,'2025-04-18T01:27:16.186Z','2025-04-18T01:27:16.186Z','local','en','markdown',NULL,'','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-18 10:32:03
