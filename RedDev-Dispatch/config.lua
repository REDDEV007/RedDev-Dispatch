Config = {}

Config.NotificationTypes = {
    Injured = {
        Message = "An injured person needs help!",
        BlipSprite = 126,
        BlipColor = 1,
        Cooldown = 1000,
        BlipDuration = 180,
        HealthThreshold = 50,
    },
    Dead = {
        Message = "A person has died save them!",
        BlipSprite = 84,
        BlipColor = 2,
        Cooldown = 1000,
        BlipDuration = 180,
        HealthThreshold = 0,
    },
}

Config.NotificationRadius = 1000 -- meters, 0 = global

Config.NotifiedJobs = {
    "ambulance",
    "police",
    "sasp",
    "firefighter",
}

Config.EnableBlips = true
Config.EnableNotifications = true
Config.MaxActiveBlips = 10
