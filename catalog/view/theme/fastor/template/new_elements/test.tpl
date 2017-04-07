<?php if ($product['attribute_groups']) { ?>
  <?php foreach ($product['attribute_groups'] as $attribute_group) { ?>
    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
      <?php if(in_array($attribute['attribute_id'], array(4,12,15))) { ?>
        <?php
          switch ($attribute['attribute_id']):
              case 4:
                  echo "<td><img src="/image/t3.jpg"></td>";
                  echo "<td>25".$attribute['text']."</td>"
                  break;
              case 12:
                  echo "id равно 12";
                  break;
              case 15:
                  echo "id равно 15";
                  break;
              default:
                  // echo "id не равно to 4, 12 или 14";
          endswitch;
         ?>
         <div>
           <span><?php echo $attribute['name']; ?>:</span>
           <span><?php echo $attribute['text']; ?> </span>
         </div>
      <?php }?>
    <?php }?>
  <?php } ?>
<?php } ?>


<div>
  <table class="attributes">
    <tbody><tr>
      <!-- diametr id = 12 -->
      <td><img src="/image/t1.jpg"></td>
      <td>10,5&Prime; </td>
      <!-- speed id = 14 -->
      <td><img src="/image/t2.jpg"></td>
      <td>20 км/ч</td>
      <!-- distance id = 4 -->
      <td><img src="/image/t3.jpg"></td>
      <td>25 км</td>
    </tr></tbody>
  </table>
</div>
