from django.db import models

class Office(models.Model):
    class Meta:
        db_table = 'office'

    location = models.ForeignKey('Location', null=True)
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Location(models.Model):
    class Meta:
        db_table = 'location'

    city = models.CharField(max_length=200)
    country = models.CharField(max_length=200)
    region = models.CharField(max_length=200)

    def __str__(self):
        return self.city + " " + self.country + " " + self.region

class User(models.Model):
    class Meta:
        db_table = 'user'

    surname = models.CharField(max_length=30)
    name = models.CharField(max_length=30)
    second_name = models.CharField(max_length=30)
    birth_date = models.DateField(null=True)
    passport = models.ForeignKey('Passport_data', null=True)
    registration_date = models.DateField(auto_now_add=True, null=True)
    attempt_count = models.IntegerField()
    location = models.ForeignKey('Location', null=True)
    
    def __str__(self):
        return self.surname + " " + self.name + " " + self.second_name + " " + self.birth_date + " " + self.registration_date + " " + self.attempt_count

class Result(models.Model):
    class Meta:
        db_table = 'result'

    user = models.ForeignKey('User', null=True)
    test_status = models.PositiveSmallIntegerField()
    test_score = models.IntegerField()
    start = models.DateTimeField()

    def __str__(self):
        return self.test_status + " " + self.test_score + " " + self.start

class Note(models.Model):
    class Meta:
        db_table = 'note'

    result = models.ForeignKey('Result', null=True)
    issuance_date = models.DateTimeField()
    user = models.ForeignKey('User', null=True)
    staff = models.ForeignKey('Staff', null=True)

    def __str__(self):
        return self.issuance_date   

class Certificate(models.Model):
    class Meta:
        db_table = 'certificate'

    user = models.ForeignKey('User', null=True)
    issuance_date = models.DateTimeField()
    staff = models.ForeignKey('Staff', null=True)

    def __str__(self):
        return self.issuance_date  
    
class Staff(models.Model):
    class Meta:
        db_table = 'staff'

    surname = models.CharField(max_length=30)
    name = models.CharField(max_length=30)
    second_name = models.CharField(max_length=30)
    birth_date = models.DateField(null=True)
    passport = models.ForeignKey('Passport_data', null=True)
    position = models.CharField(max_length=30)

    def __str__(self):
        return self.surname + " " + self.name + " " + self.second_name + " " + self.birth_date + " " + self.position

class Passport_data(models.Model):
    class Meta:
        db_table = 'passport_data'

    series = models.CharField(max_length=20)
    number = models.CharField(max_length=20)

    def __str__(self):
        return self.series + " " + self.number   
