from django.db import models
import uuid

class Office(models.Model):
    class Meta:
        db_table = 'office'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
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

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
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

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey('User', null=True)
    test_status = models.PositiveSmallIntegerField()
    test_score = models.IntegerField()
    start = models.DateTimeField()

    def __str__(self):
        return self.test_status + " " + self.test_score + " " + self.start

class Note(models.Model):
    class Meta:
        db_table = 'note'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    result = models.ForeignKey('Result', null=True)
    issuance_date = models.DateTimeField()
    user = models.ForeignKey('User', null=True)
    staff = models.ForeignKey('Staff', null=True)

    def __str__(self):
        return self.issuance_date   

class Certificate(models.Model):
    class Meta:
        db_table = 'certificate'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
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

class Request(models.Model):
    class Meta:
        db_table = 'request'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    creation_date = models.DateField(null=True)
    user = models.ForeignKey('User', null=True)
    office = models.ForeignKey('Office', null=True)

    def __str__(self):
        return self.creation_date

class Statistics(models.Model):
    class Meta:
        db_table = 'statistics'

    location = models.ForeignKey('Location', null=True)
    start_date = models.DateTimeField()
    finish_date = models.DateTimeField()
    success_rate = models.IntegerField()
    certificate_count = models.IntegerField()
    note_count = models.IntegerField()

    def __str__(self):
        return self.start_date + " " + self.finish_date + " " + self.avg_attempt + " " + self.certificate_count \
               + " " + self.note_count

class Answer(models.Model):
    class Meta:
        db_table = 'answer'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    answer_doc = models.TextField()
    question = models.ForeignKey('Question', null=True)
    result = models.ForeignKey('Result', null=True)
    answer_score = models.IntegerField()
    staff = models.ForeignKey('Staff', null=True)

    def __str__(self):
        return self.answer_doc + " " + self.answer_score
    
class Test(models.Model):
    class Meta:
        db_table = 'test'

    result = models.ForeignKey('Result', null=True)

    def __str__(self):
        return self.result 

class Question(models.Model):
    class Meta:
        db_table = 'question'

    question_doc = models.TextField()
    subtest = models.ForeignKey('Subtest', null=True)

    def __str__(self):
        return self.question_doc
    
class Block(models.Model):
    class Meta:
        db_table = 'block'

    test = models.ForeignKey('Test', null=True)
    staff = models.ForeignKey('Staff', null=True)
    block_type = models.ForeignKey('Block_type', null=True)

class Block_type(models.Model):
    class Meta:
        db_table = 'block_type'

    block_type_name = models.CharField(max_length=200)

    def __str__(self):
        return self.block_type_name
    
class Subtest(models.Model):
    class Meta:
        db_table = 'subtest'

    block = models.ForeignKey('Block', null=True)
    subtest_type = models.ForeignKey('Subtest_type', null=True)
    countable_max = models.IntegerField()
    medium_treshold = models.IntegerField()
    minimum_treshold = models.IntegerField()

    def __str__(self):
        return self.countable_max + " " + self.medium_treshold + " " + self.minimum_treshold
    
class Subtest_type(models.Model):
    class Meta:
        db_table = 'subtest_type'

    subtest_type_name = models.CharField(max_length=200)

    def __str__(self):
        return self.subtest_type_name
